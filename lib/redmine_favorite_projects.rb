# encoding: utf-8
#

require 'redmine_favorite_projects/helpers/favorite_projects_helper'


ActionDispatch::Reloader.to_prepare do
  unless ApplicationHelper.included_modules.include?(RedmineFavoriteProjects::Patches::ApplicationHelperPatch)
    ApplicationHelper.send(:include, RedmineFavoriteProjects::Patches::ApplicationHelperPatch)
  end
  unless ProjectsController.included_modules.include?(RedmineFavoriteProjects::Patches::ProjectsControllerPatch)
    ProjectsController.send(:include, RedmineFavoriteProjects::Patches::ProjectsControllerPatch)
  end
  unless ProjectsHelper.included_modules.include?(RedmineFavoriteProjects::Patches::ProjectsHelperPatch)
    ProjectsHelper.send(:include, RedmineFavoriteProjects::Patches::ProjectsHelperPatch)
  end
end
