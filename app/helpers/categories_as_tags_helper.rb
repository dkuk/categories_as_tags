
module CategoriesAsTagsHelper

  # returns link to the page with issues filtered by specified filters
  # === parameters
  # * <i>title</i> = link title text
  # * <i>filters</i> = filters to be applied (see <tt>link_to_filter_options</tt> for details)
  # * <i>options</i> = (optional) base options of the link
  # === example
  # link_to_filter 'foobar', [[ :tags, '~', 'foobar' ]]
  # link_to_filter 'foobar', [[ :tags, '~', 'foobar' ]], :project_id => project
  def link_to_filter(title, filters, options = {})
    options.merge! link_to_filter_options(filters)
    link_to title, options
  end


  # returns hash suitable for passing it to the <tt>to_link</tt>
  # === parameters
  # * <i>filters</i> = array of arrays. each child array is an array of strings:
  #                    name, operator and value
  # === example
  # link_to 'foobar', link_to_filter_options [[ :tags, '~', 'foobar' ]]
  #
  # filters = [[ :tags, '~', 'bazbaz' ], [:status_id, 'o']]
  # link_to 'bazbaz', link_to_filter_options filters
  def link_to_filter_options(filters)
    options = {
      :controller => 'issues',
      :action => 'index',
      :set_filter => 1,
      :fields => [],
      :values => {},
      :operators => {}
    }

    filters.each do |f|
      name, operator, value = f
      options[:fields].push(name)
      options[:operators][name] = operator
      options[:values][name] = [value]
    end

    options
  end

  def print_cat
    sort_by = Setting.plugin_categories_as_tags['sort_by'].to_s == 'name' ? 'issue_categories.name' : 'issues_count'
	  order_by=Setting.plugin_categories_as_tags['order'].to_s
	
	  if Setting.plugin_categories_as_tags['open_only']
	    Issue.find_by_sql "
	    SELECT issue_categories.name AS 'cat_name', COUNT(issues.id) AS 'issues_count', issue_categories.id AS 'cat_id'
	    FROM issues, issue_categories, issue_statuses
	    WHERE issues.category_id = issue_categories.id AND issues.project_id="+@project.id.to_s+" AND issues.status_id=issue_statuses.id
	    AND issue_statuses.is_closed!=1
	    GROUP BY issue_categories.id ORDER BY #{sort_by} #{order_by}"
	  else
	    Issue.find_by_sql "SELECT issue_categories.name AS 'cat_name', COUNT(issues.id) AS 'issues_count', issue_categories.id AS 'cat_id'
	    FROM issues, issue_categories
	    WHERE issues.category_id = issue_categories.id AND issues.project_id="+@project.id.to_s+"
	    GROUP BY issue_categories.id ORDER BY #{sort_by} #{order_by}"
	  end
  end
  
  def get_count_valid_cat
	  if Setting.plugin_categories_as_tags['open_only']
	    Issue.count :conditions => "issues.category_id = issue_categories.id AND issues.project_id="+@project.id.to_s+" AND issues.status_id=issue_statuses.id
	      AND issue_statuses.is_closed!=1", :include=>[:category, :status]	
	  else
	    Issue.count :conditions => "issues.category_id = issue_categories.id AND issues.project_id="+@project.id.to_s, :include=>"category"
	  end
  end  

end
