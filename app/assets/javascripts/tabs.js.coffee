$ ->
	$('.tab_paid')
		.bind 'ajax:beforeSend', () ->
			set_loading
		.bind 'ajax:success', (event, xhr, status) ->
			update_dom($(this).data('id'))
		.bind 'ajax:error', (event,xhr,status) ->
			alert('There was an error while processing the ajax request')

update_dom = (id) -> 
	$('#tab_row_'+id).remove()

set_loading = () ->
	# TODO: loading animation?