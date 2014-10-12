# encoding: utf-8

require 'redmine'

Redmine::Plugin.register :redmine_favorite_projects do
  name 'Redmine Favorite Projects plugin'
  description 'This is a favorite projects plugin for Redmine'
  version '1.0.2'
  url 'https://github.com/alexandermeindl/redmine_favorite_projects'
  author 'RedmineCRM, AlphaNodes GmbH'

  requires_redmine :version_or_higher => '2.5.2'

  default_settings = {
      'show_project_manager' => false,
      'project_manager_name' => 'Manager',
      'show_project_modules' => false,
      'show_project_progress' => false,
      'show_project_homepage' => true,
      'show_project_created_on' => true
  }
  settings(:default => default_settings, :partial => 'settings/favorite_projects')
end

require 'redmine_favorite_projects'
