$(function() {
	$('#beverages').dataTable({
		"aoColumnDefs" : [ {'bSortable' : false,'aTargets' : [ 7 ]} ],
		"aaSorting": [[1,"asc"]],
		"bPaginate": false,
		"bInfo": false
	});
});
