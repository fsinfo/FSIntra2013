$(function() {
	$('#beverages').dataTable({
		"aoColumnDefs" : [ {'bSortable' : false,'aTargets' : [ 6 ]} ],
		"aaSorting": [[1,"asc"]],
		"bPaginate": false,
		"bInfo": false
	});
});
