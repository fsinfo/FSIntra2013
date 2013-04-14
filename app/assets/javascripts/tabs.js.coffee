$ ->
	$('.edit_tab')
		.bind 'ajax:beforeSend', () ->
			$(this).find('input').prop('disabled', true)
		.bind 'ajax:success', (event, xhr, status) ->
			id = this.id.split("_").pop()
			update_dom(id)
		.bind 'ajax:error', (event,xhr,status) ->
			alert('There was an error while processing the ajax request')
		.bind 'ajax:complete', () ->
			$(this).find('input').prop('disabled', false)

update_dom = (id) -> 
	$('#tab_row_'+id).remove()
