$(function() {
	$('#beverages').dataTable({
		"aoColumnDefs" : [ {'bSortable' : false,'aTargets' : [ 6 ]} ],
		"bPaginate": false,
		"bInfo": false
	});
});