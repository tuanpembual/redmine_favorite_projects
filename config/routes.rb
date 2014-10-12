#custom routes for this plugin
match "favorite_projects/:action" => "favorite_projects"
match "favorite_projects/search" => "favorite_projects#search", :as => "search_favorite_projects"
