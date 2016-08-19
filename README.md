= Redmine Favorite Projects

Redmine Favorite Projects is a plugin for Redmine. It is a fork/merge of redmine_favorite_projects and projects_tree_view.


[![Jenkins Build Status](https://pm.alphanodes.com/jenkins/buildStatus/icon?job=Devel-build-redmine-favorite-projects)](https://pm.alphanodes.com/jenkins/job/Devel-build-redmine-favorite-projects)


== Requirements

* Redmine version >= 3.0.0
* Ruby version >= 2.0.0


== Installation

To install the redmine_favorite_projects, execute the following commands from the root of your redmine directory, assuming that your RAILS_ENV environment variable is set to "production":

 cd REDMINE_DIR
 git clone https://github.com/alphanodes/redmine_favorite_projects.git plugins/redmine_favorite_projects
 bundle rake redmine:plugins:migrate NAME=redmine_favorite_projects

More information on installing Redmine plugins can be found here: https://www.redmine.org/wiki/redmine/Plugins

After the plugin is installed and the db migration completed, you will need to restart Redmine for the plugin to be available.


== License

This plugin is licensed under the GNU GPL v2.  See GPL.txt for details.
