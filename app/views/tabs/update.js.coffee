$ ->
	$('.edit_tab').bind 'ajax:success', (event, xhr, status) ->
		id = this.id.split("_").pop()
		update_dom(id)
	$('.edit_tab').bind 'ajax:error', (event,xhr,status) ->
		alert('Ajaxerror while submitting')

update_dom = (id) -> 
	$('#tab_row_'+id).remove()
