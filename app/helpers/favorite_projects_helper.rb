# encoding: utf-8
#

module FavoriteProjectsHelper
  # include ProjectsHelper

  def favorite_tag(object, user, options={})
    return '' unless user && user.logged? && user.member_of?(object)
    favorite = FavoriteProject.favorite?(object.id, user.id)
    url = {:controller => 'favorite_projects',
           :action => (favorite ? 'unfavorite' : 'favorite'),
           :project_id => object.id}
    link = link_to(image_tag(favorite ? 'fav.png' : 'fav_off.png', :style => 'vertical-align: middle;'),
                    url,
                    :remote => true)

    content_tag("span", link, :id => "favorite_project_#{object.id}").html_safe
  end

  # Returns the css class used to identify watch links for a given +object+
  def favorite_css(objects)
    objects = Array.wrap(objects)
    id = (objects.size == 1 ? objects.first.id : 'bulk')
    "#{objects.first.class.to_s.underscore}-#{object.id}-favorite"
  end

  def table_view_modules_links(project)
    links = []
    menu_items_for(:project_menu, project) do |node|
       links << link_to(extract_node_details(node, project)[0], extract_node_details(node, project)[1]) unless node.name == :overview
    end
    links.join(", ").html_safe
  end

  def project_name(project)
    
    project_name_view = Setting.plugin_redmine_favorite_projects['project_name_view']
    
    name = case project_name_view
      when '1' then project.identifier
      when '2' then project.identifier + ': ' + project.name 
      when '3' then project.name + ': ' + project.identifier
      else project.name
    end

    project.active? ? link_to(name, project_path(project), :title => project.short_description) : h(name)
  end

  def project_manager_list(project)
    managers = ''
    manager_name = Setting.plugin_redmine_favorite_projects['project_manager_name'].to_s
    unless manager_name.empty?
      @users_by_role = project.users_by_role
      @users_by_role.keys.sort.each do |role|
        if role.to_s == manager_name
          managers = @users_by_role[role].sort.collect{|u| link_to_user u}.join(', ').html_safe
          break
        end
      end
    end
    return managers
  end

  def table_view_progress(project)
    s = ''
    cond = project.project_condition(false)

    open_issues = Issue.visible.count(:include => [:project, :status, :tracker], :conditions => ["(#{cond}) AND #{IssueStatus.table_name}.is_closed=?", false])

    if open_issues > 0
      issues_closed_percent = (1 - open_issues.to_f/project.issues.count) * 100
      s << "<div>Issues: " +
          link_to("#{open_issues} open", :controller => 'issues', :action => 'index', :project_id => project, :set_filter => 1) +
          "<small> / #{project.issues.count} total</small></div>" +
          progress_bar(issues_closed_percent, :width => '30em', :legend => '%0.0f%' % issues_closed_percent)
    end
    project_versions = project_open(project)

    unless project_versions.empty?
      s << "<div>"
      project_versions.reverse_each do |version|
        unless version.completed?
          s << "<div style=\"clear:both; display: block\">" + link_to_version(version) + ": " +
              link_to_if(version.open_issues_count > 0, l(:label_x_open_issues_abbr, :count => version.open_issues_count), :controller => 'issues', :action => 'index', :project_id => version.project, :status_id => 'o', :fixed_version_id => version, :set_filter => 1) +
              "<small> / " + link_to_if(version.closed_issues_count > 0, l(:label_x_closed_issues_abbr, :count => version.closed_issues_count), :controller => 'issues', :action => 'index', :project_id => version.project, :status_id => 'c', :fixed_version_id => version, :set_filter => 1) + "</small>. "
          s << due_date_distance_in_words(version.effective_date) if version.effective_date
          s << "</div><br />" +
              progress_bar([version.closed_percent, version.completed_percent], :width => '30em', :legend => ('%0.0f%' % version.completed_percent))
        end
      end
      s << "</div>"
    end
    s.html_safe
  end

  def project_open(project)
    with_subprojects =  Setting.display_subprojects_issues?
    project_ids = with_subprojects ? project.self_and_descendants.collect(&:id) : [project.id]

    versions = project.shared_versions || []
    versions += project.rolled_up_versions.visible if with_subprojects
    versions = versions.uniq.sort
    completed_versions = versions.select {|version| version.closed? || version.completed? }
    versions -= completed_versions

    issues_by_version = {}
    versions.reject! {|version| !project_ids.include?(version.project_id) && issues_by_version[version].blank?}
    versions
  end

end
