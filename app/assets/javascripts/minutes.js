/**
 *
 */
function registerNewMotion() {
	var html = $(newMotionHTML(getActiveSection()));
	$("section.active div.content").append(html);
	$(".chosen-field select").chosen({ placeholder_text: "Auswählen", allow_single_deselect: true });
  
	// register the remove function
	$("section.active button.remove_motion").click(function() {
		$(this).parent(".motion").detach();
	})
}

function joyride_tutorial() {
  $(document).foundation('joyride', 'start');
}


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
  activeBefore.css("padding-top", "")
  activeAfter.addClass("active")

  // initialize the redactor field
  activeAfter.find(".redactor-field textarea").redactor({
			lang: 'de',
			buttons: buttons,
			minHeight: 350,
		});

  // renumber the items
  markItemOrdering()

  $("section.active button.add_new_motion").click(registerNewMotion)


  // Hack, forces foundation to repaint the section tab bar
  $(window).trigger('resize')
})

/**
 * Shuffles the current item one to the left
 */
$("#move_item_to_left").click(function(){
	// geht nicht weiter nach links!
	if(!$("section.active").prev()) {
		return
	}
	// swap the entries in motionLevels (ugly)
	//var temp = motionLevels[parseInt(getActiveSection() - 1)]
	//motionLevels[parseInt(getActiveSection() - 1)] = motionLevels[getActiveSection()]
	//motionLevels[getActiveSection()] = temp

	var movingNode = $("section.active")
	var replaceNode = movingNode.prev()
	movingNode.insertBefore(replaceNode)

	// renumber the items
  markItemOrdering()
	$(window).trigger('resize')
})

/**
 * Shuffles the current item one to the right
 */
$("#move_item_to_right").click(function(){
	// geht nicht weiter nach rechts!
	if(!$("section.active").next().attr("data-index")) {
		return
	}
	// swap the entries in motionLevels (ugly)
	//var temp = motionLevels[parseInt(getActiveSection()) + 1]
	//motionLevels[parseInt(getActiveSection()) + 1] = motionLevels[getActiveSection()]
	//motionLevels[getActiveSection()] = temp

	var movingNode = $("section.active")
	var replaceNode = movingNode.next()
	movingNode.insertAfter(replaceNode)

	// renumber the items
  markItemOrdering()
	$(window).trigger('resize')
})

/**
 * TODO: Do i need documentataion?
 */
$("button.add_new_motion").click(registerNewMotion)


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
						'<button type="button" class="small button add_new_motion" title="Abstimmung hinzufügen">+ Abs</button>' +
						'<input id="minute_items_attributes_' + sectionCounter + '_id" name="minute[items_attributes][' + sectionCounter + '][id]" type="hidden" />' +
						'<input id="minute_items_attributes_' + sectionCounter + '_order" name="minute[items_attributes][' + sectionCounter + '][order]" type="hidden" value="' + index + '" />' +
					'</div>' +
				'</section>';
	// insert that newly discovered index
	motionLevels[sectionCounter] = 0;
	
	sectionCounter++;
	return html;
}

/**
 * This function marks the "Top i" and hidden order field as they appear on the website
 */
function markItemOrdering() {
	var i = 0
	$(".minute-item").each(function() {
  	$(this).find(".title .item-index").html(i);
  	$(this).find("input[id*=minute_items_attributes][id*=order]").attr("value", i)
  	i++
	})
}

/**
 * index = the index of the item to which this is added to
 */
function newMotionHTML(index) {
	var mi = motionLevels[index]
	var html =  '<div class="motion">' +
							'<div class="row">' +
              '  <div class="inline-field large-12 columns">' +
							'    <label for="minute_items_attributes_' + index + '_motions_attributes_' + mi + '_rationale">Antragstext</label>' +
							'    <textarea id="minute_items_attributes_' + index + '_motions_attributes_' + mi + '_rationale" name="minute[items_attributes][' + index + '][motions_attributes][' + mi + '][rationale]"></textarea>' +
							'  </div>' +
							'</div>' +

              /* MOVER */
              '<div class="row">' +
              '  <div class="inline-field chosen-field large-12 columns">' +
							'    <label for="minute_items_attributes_' + index + '_motions_attributes_' + mi + '_mover_id">Antragssteller</label>' +
							'    <select id="minute_items_attributes_' + index + '_motions_attributes_' + mi + '_mover_id" name="minute[items_attributes][' + index + '][motions_attributes][' + mi + '][mover_id]" type="text" style="width: 400px">' + 
							'      <option value=""></option>'
	for(var i in availableUsers) {
    html = html + '<option value="' + availableUsers[i].value + '">' + availableUsers[i].label + '</option>';
	}
	html = html	+ '    </select>' +
							'  </div>' +
							'</div>' +
							/* /MOVER */

							/* VOTES */
							'<div class="row">' +
							'  <div class="small-3 columns inline-field minute-motion">' +
							'    <label for="minute_items_attributes_' + index + '_motions_attributes_' + mi + '_pro">Dafür</label>' +
							'    <input id="minute_items_attributes_' + index + '_motions_attributes_' + mi + '_pro" name="minute[items_attributes][' + index + '][motions_attributes][' + mi + '][pro]" type="text" />' +
							'  </div>' +
							'  <div class="small-3 columns inline-field minute-motion">' +
							'    <label for="minute_items_attributes_' + index + '_motions_attributes_' + mi + '_abs">Enthaltung</label>' +
							'    <input id="minute_items_attributes_' + index + '_motions_attributes_' + mi + '_abs" name="minute[items_attributes][' + index + '][motions_attributes][' + mi + '][abs]" type="text" />' +
							'  </div>' +
							'  <div class="small-3 columns inline-field minute-motion">' +
							'    <label for="minute_items_attributes_' + index + '_motions_attributes_' + mi + '_con">Dagegen</label>' +
							'    <input id="minute_items_attributes_' + index + '_motions_attributes_' + mi + '_con" name="minute[items_attributes][' + index + '][motions_attributes][' + mi + '][con]" type="text" />' +
							'  </div>' +
							'  <div class="small-3 columns">' +
							'    <label class="label" for="minute_items_attributes_' + index + '_motions_attributes_' + mi + '_approved">Approved</label>' +
							'    <input id="minute_items_attributes_' + index + '_motions_attributes_' + mi + '_approved" name="minute[items_attributes][' + index + '][motions_attributes][' + mi + '][approved]" type="checkbox" />' +
							'  </div>' +
							'</div>' +
							/* /VOTES */

							'<button type="button" class="small button remove_motion" title="Doch nicht">-</button>' +
							'</div><hr/>'
	motionLevels[index] = motionLevels[index] + 1;
	return html
}


	$(function() {

		// setting up redactor
		buttons = [
			'bold', 'italic', 'underline', 'deleted', '|',
			'unorderedlist', 'orderedlist', 'outdent', 'indent', '|',
			'alignleft', 'aligncenter', 'alignright', 'justify', '|',
			'html'
		]
		$(".redactor-field textarea").redactor({
			lang: 'de',
			buttons: buttons,
			minHeight: 350,
		});

		// setting up chosen
		$(".chosen-field select").chosen({ placeholder_text: "Auswählen", allow_single_deselect: true });

		// calculating presence of a quorum
		$("#attendance .attendance-checkbox").change(function(evt){
			updateAttandanceStatus();
		});
		updateAttandanceStatus();

		// register the remove function
		$("section button.remove_motion").click(function() {
			$(this).parent(".motion").detach();
		})
		function split( val ) {
      return val.split( /,\s*/ );
    }
    function extractLast( term ) {
      return split( term ).pop();
    }

		$( "#minute_guests" )
      // don't navigate away from the field on tab when selecting an item
      .bind( "keydown", function( event ) {
        if ( event.keyCode === $.ui.keyCode.TAB &&
            $( this ).data( "ui-autocomplete" ).menu.active ) {
          event.preventDefault();
        }
      })
      .autocomplete({
        minLength: 0,
        source: function( request, response ) {
          // delegate back to autocomplete, but extract the last term
          response( $.ui.autocomplete.filter(
            availableGuests, extractLast( request.term ) ) );
        },
        focus: function() {
          // prevent value inserted on focus
          return false;
        },
        select: function( event, ui ) {
          var terms = split( this.value );
          // remove the current input
          terms.pop();
          // add the selected item
          terms.push( ui.item.value );
          // add placeholder to get the comma-and-space at the end
          terms.push( "" );
          this.value = terms.join( ", " );
          return false;
        }
      });
	});

	function updateAttandanceStatus(){
		checkboxes = $("#attendance .attendance-checkbox");
		total = checkboxes.length;
		present = checkboxes.filter(":checked").length;
		percentage = present/total*100;
		$("#attendance-total").text(total);
		$("#attendance-present").text(present);
		$("#attendance-percentage").text(percentage.toFixed(1));
		if (percentage > critical_mass) {
			$("#attendance-quorate").show();
			$("#attendance-nohouse").hide();
		} else {
			$("#attendance-quorate").hide();
			$("#attendance-nohouse").show();
		}

		// also: update the value of the input field
		// since that phunny css thing doesn't do it :\
		checkboxes.each(function() {
			if(this.checked) {
				$(this).attr("checked", "checked")
			} else {
				$(this).removeAttr("checked")
			}
		})
	}