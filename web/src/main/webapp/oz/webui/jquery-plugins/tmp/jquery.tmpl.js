/*
 * jQuery Templating Plugin
 *   NOTE: Created for demonstration purposes.
 * Copyright 2010, John Resig
 * Dual licensed under the MIT or GPL Version 2 licenses.
 * 
 * copy from http://github.com/jquery/jquery-tmpl by dragon 2010-07-21 
 * modify by king 2010-07-21 修改tmplcmd中的字段关键字
 */
(function($){
	// Override the DOM manipulation function
	var oldManip = $.fn.domManip;

	$.fn.extend({
		render: function( data ) {
			return this.map(function(i, tmpl){
				return $.render( tmpl, data );
			});
		},

		// This will allow us to do: .append( "template", dataObject )
		domManip: function( args ) {
			// This appears to be a bug in the appendTo, etc. implementation
			// it should be doing .call() instead of .apply(). See #6227
			if ( args.length > 1 && args[0].nodeType ) {
				arguments[0] = [ $.makeArray(args) ];
			}

			if ( args.length === 2 && typeof args[0] === "string" && typeof args[1] !== "string" ) {
				arguments[0] = [ $.render( args[0], args[1] ) ];
			}

			return oldManip.apply( this, arguments );
		}
	});

	$.extend({
		render: function( tmpl, data ) {
			var fn;

			// Use a pre-defined template, if available
			if ( $.templates[ tmpl ] ) {
				fn = $.templates[ tmpl ];

			// We're pulling from a script node
			} else if ( tmpl.nodeType ) {
				var node = tmpl, elemData = $.data( node );
				fn = elemData.tmpl || $.tmpl( node.innerHTML );
			}

			fn = fn || $.tmpl( tmpl );

			// We assume that if the template string is being passed directly
			// in the user doesn't want it cached. They can stick it in
			// jQuery.templates to cache it.

			if ( $.isArray( data ) ) {
				return $.map( data, function( data, i ) {
					return fn.call( data, $, data, i );
				});

			} else {
				return fn.call( data, $, data, 0 );
			}
		},

		// You can stick pre-built template functions here
		templates: {},

		/*
		 * For example, someone could do:
		 *   jQuery.templates.foo = jQuery.tmpl("some long templating string");
		 *   $("#test").append("foo", data);
		 */

		tmplcmd: {
			"each": {
				_default: [ null, "$i" ],
				prefix: "$.each($1,function($2){with(this){",
				suffix: "}});"
			},
			"if": {
				prefix: "if($1){",
				suffix: "}"
			},
			"else": {
				prefix: "}else{"
			},
			"html": {
				prefix: "_.push(typeof $1==='function'?$1.call(this):$1);"
			},
			"=": {
				_default: [ "this" ],
				prefix: "_.push($.encode(typeof $1==='function'?$1.call(this):$1));"
			}
		},

		encode: function( text ) {
			return text != null ? document.createTextNode( text.toString() ).nodeValue : "";
		},

		tmpl: function(str, data, i) {
			// Generate a reusable function that will serve as a template
			// generator (and which will be cached).
			var fn = new Function("jQuery","$data","$i",
				"var $=jQuery,_=[];_.data=$data;_.index=$i;" +

				// Introduce the data as local variables using with(){}
				"with($data){_.push('" +

				// Convert the template into pure JavaScript
				str
					.replace(/[\r\t\n]/g, " ")
					.replace(/\${([^}]*)}/g, "{{= $1}}")
					.replace(/{{(\/?)(\w+|.)(?:\((.*?)\))?(?: (.*?))?}}/g, function(all, slash, type, fnargs, args) {
						var tmpl = $.tmplcmd[ type ];
						if ( !tmpl ) {
							throw "Template not found: " + type;
						}

						var def = tmpl._default;

						return "');" + tmpl[slash ? "suffix" : "prefix"]
							.split("$1").join(args || def[0])
							.split("$2").join(fnargs || def[1]) + "_.push('";
					})
				+ "');}return $(_.join('')).get();");
			// Provide some basic currying to the user
			return data ? fn.call( data, $, data, i ) : fn;
		}
	});
})(jQuery);