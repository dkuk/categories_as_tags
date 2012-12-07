document.observe('dom:loaded', function(){
	$$('td.category').each(function(e){
		if($('af_category_id'))
			e.innerHTML="<a href=\"../projects/"+$('af_project_identifier').innerHTML+"/issues?fields%5B%5D=category_id&fields%5B%5D=status_id&operators%5Bcategory_id%5D=~&operators%5Bstatus_id%5D=o&set_filter=1&values%5Bcategory_id%5D%5B%5D="+$('af_category_id').innerHTML+"&values%5Bstatus_id%5D%5B%5D=\">"+e.innerHTML+"</a>"
		});
	});