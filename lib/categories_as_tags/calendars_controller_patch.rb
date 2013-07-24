require_dependency 'calendars_controller'

module CategoriesAsTags
  module CalendarsControllerPatch
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
