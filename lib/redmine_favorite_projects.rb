# encoding: utf-8
#

require 'redmine_favorite_projects/patches/application_helper_patch.rb'

Rails.configuration.to_prepare do
  require_dependency 'redmine_favorite_projects/helpers/favorite_projects_helper'
  require_dependency 'redmine_favorite_projects/patches/projects_controller_patch.rb'
  require_dependency 'redmine_favorite_projects/patches/project_patch.rb'
  require_dependency 'redmine_favorite_projects/patches/projects_helper_patch.rb'
  require_dependency 'redmine_favorite_projects/patches/setting_patch.rb'

  require_dependency 'redmine_favorite_projects/hooks.rb'
end
