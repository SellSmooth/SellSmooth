 var Observer = new Class({

	Implements: [Options, Events],

	options: {
		periodical: false,
		delay: 1000
	},

	initialize: function(el, onFired, options){
		this.element = $(el) || $$(el);
		this.addEvent('onFired', onFired);
		this.setOptions(options);
		this.bound = this.changed.bind(this);
		this.resume();
	},

	changed: function() {
		var value = this.element.get('value');
		if ($equals(this.value, value)) return;
		this.clear();
		this.value = value;
		this.timeout = this.onFired.delay(this.options.delay, this);
	},

	setValue: function(value) {
		this.value = value;
		this.element.set('value', value);
		return this.clear();
	},

	onFired: function() {
		this.fireEvent('onFired', [this.value, this.element]);
	},

	clear: function() {
		//this.clear(this.timeout || null);
		return this;
	},

	pause: function(){
		if (this.timer) $clear(this.timer);
		else this.element.removeEvent('keyup', this.bound);
		return this.clear();
	},

	resume: function(){
		this.value = this.element.get('value');
		if (this.options.periodical) this.timer = this.changed.periodical(this.options.periodical, this);
		else this.element.addEvent('keyup', this.bound);
		return this;
	}

});

 window.addEvent('domready', function() {
 	$('add_new_object').addEvent('click', function(){
	    if($('pictue_view_window') !=null)$('pictue_view_window').remove();
		var box = new mBox.Modal({
			id : 'pictue_view_window',
			openOnInit:true,
			title: '<p><p>',
			position: {
				x: 'center',			// horizontal position (use array to define outside or inside positions e.g. ['right', 'inside'] or ['left', 'center'])
				y: 'top'				// vertical position (use array to define outside or inside positions e.g. ['top', 'inside'] or ['bottom', 'center'])
			},		
			load: 'ajax',
			url : '/admind3hf3bwelu/product/create',
			buttons: [
				{title: '[% loc_inf.btn_cancel %]',addClass: 'btn btn-default'},
				{
					title: '[% loc_inf.btn_save %]',
					addClass: 'btn btn-default',
					event: function(e) {
						
					}
				}
			],
		});
		box.setPosition();
	});

});