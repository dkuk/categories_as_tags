require 'redmine'

Redmine::Plugin.register :categories_as_tags do
  name 'Redmine Categories As Tags plugin'
  author 'Pitin Vladimir Vladimirovich'
  author_url 'http://pitin.su'
  description 'It shows categories in sidebar'
  version '0.1'
  requires_redmine :version_or_higher => "2.0"
  
  settings :default => {
    :sidebar => 'none',
    :count => 0,
    :open_only => 0,
    :sort_by => 'name',
    :order => 'asc'
  }, :partial => 'categories_tags/settings'  
end

Rails.application.config.to_prepare do
	IssuesController.send(:include, CategoriesAsTags::IssuesControllerPatch)
	GanttsController.send(:include, CategoriesAsTags::GanttsControllerPatch)
end

require 'hooks/views_issues_hook'
