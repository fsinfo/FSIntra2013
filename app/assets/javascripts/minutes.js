/**
 * This counter holds the number of currently inserted items in this minute.
 * TODO: This currently works just for new protocols
 */
sectionCounter = 4

/**
 * Adds a new item after the currently displayed one.
 */
$("#add_new_item").click(function() {
	// activeSection is the id of the active section
	activeSection = getActiveSection()
	
	// then insert the new section before the active section
	var html = newSectionHTML(activeSection)
  $("section.active").before(html)

  // Mark the newly inserted section as active
  var activeBefore = $("section.active")
  var activeAfter = $("section.active").prev()
  activeBefore.removeClass("active")
  activeAfter.addClass("active")

  // initialize the redactor field
  activeAfter.find(".redactor-field textarea").redactor({
			lang: 'de',
			buttons: buttons,
			minHeight: 350,
		});

  // Hack, forces foundation to repaint the section tab bar
  $(window).trigger('resize')
})

/**
 * Shuffles the current item one to the left
 */
$().click(function(){

})

/**
 * Shuffles the current item one to the right
 */
$().click(function(){

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
	var html = '<section data-index="' + sectionCounter+ '" class="minute-item">' +
					'<p class="title" data-section-title>' +
						'<a href="#"><b><span class="translation_missing" title="translation missing: de.TOP">TOP</span> <span class="item-index">' + index + '</span></b></a>' +
					'</p>' +
					'<div class="content" data-section-content>' +
						'<div class="inline-field">' +
							'<label for="minute_items_attributes_' + sectionCounter + '_title">Titel</label>' +
							'<input id="minute_items_attributes_' + sectionCounter + '_title" name="minute[items_attributes][' + sectionCounter + '][title]" type="text" value="" />' +
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

/**
 * This function marks the "Top i" and hidden order field as they appear on the website
 */
function markItemOrdering() {
	var i = 0
	$(".minute-item").each(function() {
  	$(this).attr("data-index", i)
  	$(this).find(".title .item-index").html(i);
  	i++
	})
}