#custom routes for this plugin
match 'favorite_projects/:action', :to => 'favorite_projects', via: [:get, :put, :post]
match 'favorite_projects/search', :to => 'favorite_projects#search', :as => 'search_favorite_projects', via: [:get, :put, :post]
