# encoding: utf-8

require_dependency 'project'

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
  end
end
