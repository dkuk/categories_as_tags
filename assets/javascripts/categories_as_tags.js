$(document).ready(function(){
  if ($('#af_category_id').length > 0) {
    $('td.category').wrapInner("<a href=\"../projects/"+$("#af_project_identifier").html()+"/issues?fields%5B%5D=category_id&fields%5B%5D=status_id&operators%5Bcategory_id%5D=~&operators%5Bstatus_id%5D=o&set_filter=1&values%5Bcategory_id%5D%5B%5D="+$("#af_category_id").html()+"&values%5Bstatus_id%5D%5B%5D=\" />");
  }
});