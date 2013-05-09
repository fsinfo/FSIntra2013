/**
 * This counter holds the number of currently inserted items in this minute.
 * TODO: This currently works just for new protocols
 */
sectionCounter = 4

/**
 * Adds a new item after the currently displayed one.
 *
 */
$("#add_new_item").click(function() {
	var html = newSectionHTML(getActiveSection());
  $("section.active").after(html);

  // Hack, forces foundation to repaint the section tab bar
  $(window).trigger('resize')
})

/**
 * TODO: Is this needed?
 */
getActiveSection = function() {
	return $("section.active").attr("data-index")
}

/**
 * index = index of the new top, e.g. 3 => TOP 3
 */
function newSectionHTML(index) {
	var html = '<section data-index="' + sectionCounter+ '">' +
					'<p class="title" data-section-title>' +
						'<a href="#"><b><span class="translation_missing" title="translation missing: de.TOP">TOP</span> ' + index + '</b></a>' +
					'</p>' +
					'<div class="content" data-section-content>' +
						'<ul class="button-group">' +
						  '<li><button type="button" href="#" class="small button" title="Nach vorne verschieben">&lt;</button></li>' +
						  '<li><button type="button" href="#" class="small button" title="Neuen Tagesordnungspunkt anlegen">Neuer TOP</button></li>' +
						  '<li><button type="button" href="#" class="small button" title="Nach hinten verschieben">&gt;</button></li>' +
						'</ul>' +
						'<div class="inline-field">' +
							'<label for="minute_items_attributes_' + sectionCounter + '_title">Titel</label>' +
							'<input id="minute_items_attributes_' + sectionCounter + '_title" name="minute[items_attributes][' + sectionCounter + '][title]" type="text" value="Verschiedenes" />' +
						'</div>' +
						'<div class="redactor-field">' +
							'<textarea id="minute_items_attributes_' + sectionCounter + '_content" name="minute[items_attributes][' + sectionCounter + '][content]">' +
							'</textarea>' +
						'</div>' +
						'<input id="minute_items_attributes_' + sectionCounter + '_id" name="minute[items_attributes][' + sectionCounter + '][id]" type="hidden" />' +
						'<input id="minute_items_attributes_' + sectionCounter + '_order" name="minute[items_attributes][' + sectionCounter + '][order]" type="hidden" value="' + index + '" />' +
					'</div>' +
				'</section>';
	sectionCounter++;
	return html;
}
