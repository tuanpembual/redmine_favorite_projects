# encoding: utf-8

module RedmineFavoriteProjects
  module Patches

    module ProjectPatch
      def self.included(base)
        base.class_eval do
          unloadable
          safe_attributes 'project_name_view'
        end
      end
    end

    Project.send(:include, RedmineFavoriteProjects::Patches::ProjectPatch)
  end
end