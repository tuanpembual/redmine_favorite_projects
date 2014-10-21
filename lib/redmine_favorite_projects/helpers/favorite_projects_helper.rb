# encoding: utf-8
#

module RedmineFavoriteProjects

  module Helper

    def roles_for_select(selected=nil)
      options = []
      @roles = Role.givable.all
      for role in @roles
        options << role.name
      end
      options_for_select(options, :selected => selected)
    end

    def project_name_for_select(selected=nil, with_system_default=false)
      
      options = {}
      
      if with_system_default
        options[l(:project_name_view_default)] = '0'
      end
      
      options[l(:project_name_view_name)] = '1'
      options[l(:project_name_view_id)] = '2'
      options[l(:project_name_view_id_name)] = '3'
      options[l(:project_name_view_name_id)] = '4'
      
      options_for_select(options, :selected => selected)
    end

  end

end

ActionView::Base.send :include, RedmineFavoriteProjects::Helper
