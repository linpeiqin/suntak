// ComboBox, a Select Box Enhancer for jQuery and Protoype
(function() {
  var SelectParser;

  SelectParser = (function() {

    function SelectParser() {
      this.options_index = 0;
      this.parsed = [];
    }

    SelectParser.prototype.add_node = function(child) {
      if (child.nodeName === "OPTGROUP") {
        return this.add_group(child);
      } else {
        return this.add_option(child);
      }
    };

    SelectParser.prototype.add_group = function(group) {
      var group_position, option, _i, _len, _ref, _results;
      group_position = this.parsed.length;
      this.parsed.push({
        array_index: group_position,
        group: true,
        label: group.label,
        children: 0,
        disabled: group.disabled
      });
      _ref = group.childNodes;
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        option = _ref[_i];
        _results.push(this.add_option(option, group_position, group.disabled));
      }
      return _results;
    };

    SelectParser.prototype.add_option = function(option, group_position, group_disabled) {
      if (option.nodeName === "OPTION") {
        if (option.text !== "") {
          if (group_position != null) this.parsed[group_position].children += 1;
          this.parsed.push({
            array_index: this.parsed.length,
            options_index: this.options_index,
            value: option.value,
            text: option.text,
            html: option.innerHTML,
            selected: option.selected,
            disabled: group_disabled === true ? group_disabled : option.disabled,
            group_array_index: group_position,
            classes: option.className,
            style: option.style.cssText
          });
        } else {
          this.parsed.push({
            array_index: this.parsed.length,
            options_index: this.options_index,
            empty: true
          });
        }
        return this.options_index += 1;
      }
    };

    return SelectParser;

  })();

  SelectParser.select_to_array = function(select) {
    var child, parser, _i, _len, _ref;
    parser = new SelectParser();
    _ref = select.childNodes;
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      child = _ref[_i];
      parser.add_node(child);
    }
    return parser.parsed;
  };

  this.SelectParser = SelectParser;

}).call(this);

(function() {
  var AbstractComboBox, root;

  root = this;

  AbstractComboBox = (function() {

    function AbstractComboBox(form_field, options) {
      this.form_field = form_field;
      this.options = options != null ? options : {};
      this.set_default_values();
      this.editable = this.options.editable || false;
      this.setup();
      this.set_up_html();
      this.register_observers();
      this.finish_setup();
    }

    AbstractComboBox.prototype.set_default_values = function() {
      var _this = this;
      this.click_test_action = function(evt) {
        return _this.test_active_click(evt);
      };
      this.activate_action = function(evt) {
        return _this.activate_field(evt);
      };
      this.active_field = false;
      this.mouse_on_container = false;
      this.options_showing = false;
      this.option_highlighted = null;
      return this.option_single_selected = null;
    };

    AbstractComboBox.prototype.mouse_enter = function() {
      return this.mouse_on_container = true;
    };

    AbstractComboBox.prototype.mouse_leave = function() {
      return this.mouse_on_container = false;
    };

    AbstractComboBox.prototype.input_focus = function(evt) {
      var _this = this;
      if (!this.active_field) {
        return setTimeout((function() {
          return _this.container_mousedown();
        }), 50);
      }
    };

    AbstractComboBox.prototype.input_blur = function(evt) {
      var _this = this;
      if (!this.mouse_on_container) {
        this.active_field = false;
        return setTimeout((function() {
          return _this.blur_test();
        }), 100);
      }
    };

    AbstractComboBox.prototype.result_add_option = function(option) {
      var classes, style;
      if (!option.disabled) {
        option.dom_id = this.container_id + "_o_" + option.array_index;
        classes = ["active-result"];
        if (option.selected) classes.push("result-selected");
        if (option.group_array_index != null) classes.push("group-option");
        if (option.classes !== "") classes.push(option.classes);
        style = option.style.cssText !== "" ? " style=\"" + option.style + "\"" : "";
        return '<li id="' + option.dom_id + '" class="' + classes.join(' ') + '"' + style + '>' + option.html + '</li>';
      } else {
        return "";
      }
    };

    AbstractComboBox.prototype.results_update_field = function() {
      this.result_clear_highlight();
      this.option_single_selected = null;
      return this.options_build();
    };

    AbstractComboBox.prototype.options_toggle = function() {
      if (this.options_showing) {
        return this.options_hide();
      } else {
        return this.options_show();
      }
    };
    
    AbstractComboBox.prototype.keyup_checker = function(evt) {
      var stroke, _ref;
      stroke = (_ref = evt.which) != null ? _ref : evt.keyCode;
      switch (stroke) {
        case 13:
          evt.preventDefault();
          if (this.options_showing) return this.option_select(evt);
          break;
        case 27:
          if (this.options_showing) this.options_hide();
          return true;
        case 9:
        case 38:
        case 40:
        case 16:
        case 91:
        case 17:
          break;
        default:
          return this.updateValue();
      }
    };

    AbstractComboBox.prototype.generate_field_id = function() {
      var new_id;
      new_id = this.generate_random_id();
      this.form_field.id = new_id;
      return new_id;
    };

    AbstractComboBox.prototype.generate_random_char = function() {
      var chars, newchar, rand;
      chars = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXTZ";
      rand = Math.floor(Math.random() * chars.length);
      return newchar = chars.substring(rand, rand + 1);
    };

    return AbstractComboBox;

  })();

  root.AbstractComboBox = AbstractComboBox;

}).call(this);

(function() {
  var $, ComboBox, get_side_border_padding, root,
    __hasProp = Object.prototype.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

  root = this;

  $ = jQuery;

  $.fn.extend({
    combobox: function(options) {
      return $(this).each(function(input_field) {
        if (!($(this)).hasClass("combobox-done")) return new ComboBox(this, options);
      });
    },
    reoladCombobox:function(){
  	  return $(this).each(function(input_field) {
	        if (!($(this)).hasClass("combobox-done")) return;
	        $(this).data("ComboBox").options_build();
	      });
    }
  });

  ComboBox = (function(_super) {

    __extends(ComboBox, _super);

    function ComboBox() {
      ComboBox.__super__.constructor.apply(this, arguments);
    }

    ComboBox.prototype.setup = function() {
	  this.form_field_jq = $(this.form_field);
	  this.form_field_jq.data("ComboBox",this);
      return this.form_field_jq;
    };

    ComboBox.prototype.finish_setup = function() {
      return this.form_field_jq.addClass("combobox-done");
    };

    ComboBox.prototype.set_up_html = function() {
      var container_div, dd_top, dd_width, sf_width;
      this.container_id = this.form_field.id.length ? this.form_field.id.replace(/(:|\.)/g, '_') : this.generate_field_id();
      this.container_id += "_combobox";
      this.f_width = this.form_field_jq.outerWidth();
      container_div = $("<div />", {
        id: this.container_id,
        "class": "combobox-container",
        style: 'width: ' + this.f_width + 'px;'
      });
      
	  container_div.html('<a href="javascript:void(0)" class="combobox smartcombobox" ><input type="text" class="valueinput"  name="subject" autocomplete="off" value="" focusable="false"><div><b></b></div></a><div class="combobox-drop" style="left:-9000px;"><ul class="combobox-results"></ul></div>');
	
      this.form_field_jq.hide().after(container_div);
      this.container = $('#' + this.container_id);
      this.container.addClass("combobox-container");
      this.dropdown = this.container.find('div.combobox-drop').first();
      dd_top = this.container.height();     
      dd_width = this.f_width - get_side_border_padding(this.dropdown);
      // 临时措施，否则IE下会错位
      if(!($.boxModel))
    	  dd_width += 2;
      this.dropdown.css({
        "width": dd_width + "px",
        "top": dd_top + "px"
      });
      this.input_field = this.container.find('input').first();
      
	  this.input_field.get(0).readOnly = !this.editable;
	  
      this.select_options = this.container.find('ul.combobox-results').first();
      this.options_build();
      this.set_tab_index();
      return this.form_field_jq.trigger("liszt:ready", {
        chosen: this
      });
    };

    ComboBox.prototype.register_observers = function() {
      var _this = this;
      this.container.mousedown(function(evt) {
        return _this.container_mousedown(evt);
      });
      this.container.mouseup(function(evt) {
        return _this.container_mouseup(evt);
      });
      this.container.mouseenter(function(evt) {
        return _this.mouse_enter(evt);
      });
      this.container.mouseleave(function(evt) {
        return _this.mouse_leave(evt);
      });
      this.select_options.mouseup(function(evt) {
        return _this.select_options_mouseup(evt);
      });
      this.select_options.mouseover(function(evt) {
        return _this.select_options_mouseover(evt);
      });
      this.select_options.mouseout(function(evt) {
        return _this.select_options_mouseout(evt);
      });
      this.form_field_jq.bind("liszt:updated", function(evt) {
        return _this.results_update_field(evt);
      });
      this.input_field.blur(function(evt) {
        return _this.input_blur(evt);
      });
      this.input_field.keyup(function(evt) {
        return _this.keyup_checker(evt);
      });
      this.input_field.keydown(function(evt) {
        return _this.keydown_checker(evt);
      });
        return this.container.click(function(evt) {
          return evt.preventDefault();
        });
    };

    ComboBox.prototype.input_field_disabled = function() {
      this.is_disabled = this.form_field_jq[0].disabled;
      if (this.is_disabled) {
        this.container.addClass('combobox-disabled');
        this.input_field[0].disabled = true;
        return this.close_field();
      } else {
        this.container.removeClass('combobox-disabled');
       return this.input_field[0].disabled = false;
      }
    };

    ComboBox.prototype.container_mousedown = function(evt) {
      if (!this.is_disabled) {
        if (evt && evt.type === "mousedown") evt.stopPropagation();
        
        if (!this.active_field) {
            $(document).click(this.click_test_action);
            this.options_show();
          } else if (evt && ($(evt.target).parents("a.combobox").length)) {
            evt.preventDefault();
            this.options_toggle();
          }
          return this.activate_field();
      }
    };

    ComboBox.prototype.container_mouseup = function(evt) {
     
    };

    ComboBox.prototype.blur_test = function(evt) {
      if (!this.active_field && this.container.hasClass("combobox-container-active")) {
        return this.close_field();
      }
    };

    /**
     * 关闭操作
     */
    ComboBox.prototype.close_field = function() {
      $(document).unbind("click", this.click_test_action);
      this.active_field = false;
      this.options_hide();
      return this.container.removeClass("combobox-container-active");
    };

    /**
     * 激活操作
     */
    ComboBox.prototype.activate_field = function() {
      this.container.addClass("combobox-container-active");
      this.active_field = true;
      this.input_field.val(this.input_field.val());
      return this.input_field.focus();
    };

    ComboBox.prototype.test_active_click = function(evt) {
      if ($(evt.target).parents('#' + this.container_id).length) {
        return this.active_field = true;
      } else {
        return this.close_field();
      }
    };

    /**
     * 构造选项
     */
    ComboBox.prototype.options_build = function() {
      var content, data, _i, _len, _ref;
      this.parsing = true;
      this.options_data = root.SelectParser.select_to_array(this.form_field);
      content = '';
      _ref = this.options_data;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        data = _ref[_i];
        if (data.group) {
          content += this.result_add_group(data);
        } else if (!data.empty) {
          content += this.result_add_option(data);
          if(data.selected){
        	  this.input_field.val(data.text);
          }
        }
      }
      this.input_field_disabled();
      this.select_options.html(content);
      return this.parsing = false;
    };

    ComboBox.prototype.result_add_group = function(group) {
      if (!group.disabled) {
        group.dom_id = this.container_id + "_g_" + group.array_index;
        return '<li id="' + group.dom_id + '" class="group-result">' + $("<div />").text(group.label).html() + '</li>';
      } else {
        return "";
      }
    };
    /**
     * 选中指定对象
     */
    ComboBox.prototype.option_do_highlight = function(el) {
      var high_bottom, high_top, maxHeight, visible_bottom, visible_top;
      if (el.length) {
        this.result_clear_highlight();
        this.option_highlight = el;
        this.option_highlight.addClass("highlighted");
        maxHeight = parseInt(this.select_options.css("maxHeight"), 10);
        visible_top = this.select_options.scrollTop();
        visible_bottom = maxHeight + visible_top;
        high_top = this.option_highlight.position().top + this.select_options.scrollTop();
        high_bottom = high_top + this.option_highlight.outerHeight();
        if (high_bottom >= visible_bottom) {
          return this.select_options.scrollTop((high_bottom - maxHeight) > 0 ? high_bottom - maxHeight : 0);
        } else if (high_top < visible_top) {
          return this.select_options.scrollTop(high_top);
        }
      }
    };

    ComboBox.prototype.result_clear_highlight = function() {
      if (this.option_highlight) this.option_highlight.removeClass("highlighted");
      return this.option_highlight = null;
    };

    ComboBox.prototype.options_show = function() {
      var dd_top;
        if (this.option_single_selected) {
          this.option_do_highlight(this.option_single_selected);
        }
      dd_top = this.container.height() - 1;
      this.dropdown.css({
        "top": dd_top + "px",
        "left": 0
      });
      this.options_showing = true;
      this.input_field.focus();
   //   return this.winnow_results();
    };

    ComboBox.prototype.options_hide = function() {
      this.result_clear_highlight();
      this.dropdown.css({
        "left": "-9000px"
      });
      return this.options_showing = false;
    };

    ComboBox.prototype.updateValue = function() {
   	 if (this.options_showing) this.options_hide();
   	 this.form_field.options[0].selected = true;
   	 this.form_field.options[0].value = this.input_field.val();
   }
    
    ComboBox.prototype.set_tab_index = function(el) {
      var ti;
      if (this.form_field_jq.attr("tabindex")) {
        ti = this.form_field_jq.attr("tabindex");
        this.form_field_jq.attr("tabindex", -1);
          return this.input_field.attr("tabindex", ti);
      }
    };

    ComboBox.prototype.select_options_mouseup = function(evt) {
      var target;
      target = $(evt.target).hasClass("active-result") ? $(evt.target) : $(evt.target).parents(".active-result").first();
      if (target.length) {
        this.option_highlight = target;
        return this.option_select(evt);
      }
    };

    ComboBox.prototype.select_options_mouseover = function(evt) {
      var target;
      target = $(evt.target).hasClass("active-result") ? $(evt.target) : $(evt.target).parents(".active-result").first();
      if (target) return this.option_do_highlight(target);
    };

    ComboBox.prototype.select_options_mouseout = function(evt) {
      if ($(evt.target).hasClass("active-result" || $(evt.target).parents('.active-result').first())) {
        return this.result_clear_highlight();
      }
    };

    ComboBox.prototype.option_select = function(evt) {
      var high, high_id, item, position;
      if (this.option_highlight) {
        high = this.option_highlight;
        high_id = high.attr("id");
        this.result_clear_highlight();
        this.select_options.find(".result-selected").removeClass("result-selected");
        this.option_single_selected = high;
        high.addClass("result-selected");
        position = high_id.substr(high_id.lastIndexOf("_") + 1);
        item = this.options_data[position];
        item.selected = true;
        this.form_field.options[item.options_index].selected = true;
        this.options_hide();
          this.input_field.val(item.text);
          return  this.form_field_jq.trigger("change");
      }
    };

    ComboBox.prototype.option_activate = function(el) {
      return el.addClass("active-result");
    };

    ComboBox.prototype.option_deactivate = function(el) {
      return el.removeClass("active-result");
    };

    ComboBox.prototype.keydown_arrow = function() {
      var first_active, next_sib;
      if (!this.option_highlight) {
        first_active = this.select_options.find("li.active-result").first();
        if (first_active) this.option_do_highlight($(first_active));
      } else if (this.options_showing) {
        next_sib = this.option_highlight.nextAll("li.active-result").first();
        if (next_sib) this.option_do_highlight(next_sib);
      }
      if (!this.options_showing) return this.options_show();
    };

    ComboBox.prototype.keyup_arrow = function() {
      var prev_sibs;
      if (!this.options_showing) {
        return this.options_show();
      } else if (this.option_highlight) {
        prev_sibs = this.option_highlight.prevAll("li.active-result");
        if (prev_sibs.length) {
          return this.option_do_highlight(prev_sibs.first());
        } else {
          return this.result_clear_highlight();
        }
      }
    };

    ComboBox.prototype.keydown_checker = function(evt) {
      var stroke, _ref;
      stroke = (_ref = evt.which) != null ? _ref : evt.keyCode;
      switch (stroke) {
        case 8:
          break;
        case 9:
          if (this.options_showing) this.option_select(evt);
          this.mouse_on_container = false;
          break;
        case 13:
          evt.preventDefault();
          break;
        case 38:
          evt.preventDefault();
          this.keyup_arrow();
          break;
        case 40:
          this.keydown_arrow();
          break;
      }
    };

    ComboBox.prototype.generate_random_id = function() {
      var string;
      string = "sel" + this.generate_random_char() + this.generate_random_char() + this.generate_random_char();
      while ($("#" + string).length > 0) {
        string += this.generate_random_char();
      }
      return string;
    };

    return ComboBox;

  })(AbstractComboBox);

  get_side_border_padding = function(elmt) {
    var side_border_padding;
    return side_border_padding = elmt.outerWidth() - elmt.width();
  };

  root.get_side_border_padding = get_side_border_padding;

}).call(this);
