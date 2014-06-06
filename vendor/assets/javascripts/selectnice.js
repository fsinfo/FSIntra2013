;(function ( $ ) {

	// case insensitive :contains selector
	// see: http://css-tricks.com/snippets/jquery/make-jquery-contains-case-insensitive/
	$.expr[":"].cicontains = $.expr.createPseudo(function(arg) {
		return function( elem ) {
			return $(elem).text().toLowerCase().indexOf(arg.toLowerCase()) >= 0;
		};
	});

	$.fn.selectnice = function(type, settings, selectize_settings) {
		settings = settings || {};
		selectize_settings = selectize_settings || {};
		/**
		 * type: choose mode, one of
		 *     + 'single' (aka 'select')
		 *     + 'multiple' (aka 'select')
		 *     + 'tags' (aka 'tag')
		 *     + 'livesearch' (aka 'live')
		 * settings: custom settings for our selectnice magic
		 *     + objs: jQuery selector specifying elements which should be filtered
		 *             in 'livesearch' mode
		 *     + tags: tags which are expanded into selectize options, each tag
		 *             is added as value/text pair to the 'options' of selectize,
		 *             where both values of the pair are equal
		 * selectize_settings: settings which are directly passed to selectize
		 */

		if (settings.tags) {
			if (!("options" in selectize_settings)) selectize_settings.options = [];
			for(i=0;i<settings.tags.length;i++) {
				selectize_settings.options.push({value: settings.tags[i], text: settings.tags[i]});
			}
		}


		if (type === "single" || type === "multiple" || type == "select") {
			/* BEGIN SINGLE SELECT */
			$(this).selectize($.extend({
				create: false,
				sortField: 'text',
				render: {
					option_create: function(data, escape) {
						return '<div class="create">Hinzufügen: <strong>' + escape(data.input) + '</strong></div>';
					},
				},
			}, selectize_settings));
			/* END SINGLE SELECT */
		}

		if (type === "tags" || type === "tag" || type === "live" || type == "livesearch") {
			/* BEGIN TAG SELECT */
			var $select = $(this).selectize($.extend({
				delimiter: ',',
				create: true,
				render: {
					option_create: function(data, escape) {
						return '<div class="create">Hinzufügen: <strong>' + escape(data.input) + '</strong></div>';
					},
				},
			}, selectize_settings));
			/* END TAG SELECT */

			if (type === "live" || type == "livesearch") {
				/* BEGIN LIVESEARCH SPECIFIC */
				var selectize = $select[0].selectize;
				selectize.on('item_add', callback_item_added);
				selectize.on('item_remove', callback_item_removed);
				var objs = $(settings.objs);

				function callback_item_added(value) {
					close_dropdown(); // better safe than sorry
					filter_objs(value);
					close_dropdown();
				}

				function callback_item_removed(value) {
					objs.show();
					$.each(selected_tags(), function(i, val) { filter_objs(val); });
				}

				function filter_objs(value) {
					objs.filter(":not(:cicontains(" + value + "))").hide();
				}

				function close_dropdown() {
					selectize.close();
					// dirty hack, but otherwise it might not be closed after adding custom items
					setTimeout(function(){selectize.close();}, 20);
				}

				function selected_tags() {
					return selectize.getValue().split(",");
				}
				/* END LIVESEARCH SPECIFIC */
			}
		}

		return this;
	}
	
}( jQuery ));