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

  end

end

ActionView::Base.send :include, RedmineFavoriteProjects::Helper
