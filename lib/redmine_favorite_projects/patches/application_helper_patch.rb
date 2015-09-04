# encoding: utf-8

require_dependency 'application_helper'

module RedmineFavoriteProjects
  module Patches

    module ApplicationHelperPatch

      def self.included(base) # :nodoc:
        base.send(:include, InstanceMethods)
        base.class_eval do
          unloadable
          alias_method_chain :render_project_jump_box, :only_favorites
          private
          def check_favorite_id(project_ids, project_id)
            if Setting.plugin_redmine_favorite_projects['default_favorite_behavior'].to_s.empty?
              !project_ids.include?(project_id)
            else
              project_ids.include?(project_id)
            end
          end
        end
      end

      module InstanceMethods
        def render_project_jump_box_with_only_favorites
          return unless User.current.logged?
          favorite_projects = FavoriteProject.where(:user_id => User.current.id)
          favorite_projects_ids = favorite_projects.map(&:project_id)
          projects = User.current.memberships.collect(&:project).compact.uniq.select{|p|check_favorite_id(favorite_projects_ids, p.id) && p.active? }
          if projects.any?
            s = '<select onchange="if (this.value != \'\') { window.location = this.value; }">' +
            "<option value=''>#{ l(:label_jump_to_a_project) }</option>" +
            '<option value="" disabled="disabled">---</option>'
            s << project_tree_options_for_select(projects, :selected => @project) do |p|
              { :value => url_for(:controller => 'projects', :action => 'show', :id => p, :jump => current_menu_item) }
            end
            s << '</select>'
            s.html_safe
          end
        end
      end
    end
  end
end
