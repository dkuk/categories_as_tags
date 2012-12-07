require_dependency 'gantts_controller'

module CategoriesAsTags
  module GanttsControllerPatch
    def self.included(base)
		base.extend(ClassMethods)
		base.send(:include, InstanceMethods)	
	
		base.class_eval do
			helper :categories_as_tags
		end
    end
	
	module ClassMethods   
	end
	
	module InstanceMethods	
			
	end
  end
end
