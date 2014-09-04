module RedmineCategoriesAsTags
  module Hooks
    class ViewsIssuesHook < Redmine::Hook::ViewListener
      render_on :view_issues_sidebar_planning_bottom, partial: 'issues/categories_sidebar'
      render_on :view_issues_form_details_top, partial: 'issues/category_id'
      render_on :view_layouts_base_body_bottom, partial: 'issues/category_ids'
      render_on :view_layouts_base_html_head, partial: 'hooks/categories_as_tags/html_head'
    end
  end
end