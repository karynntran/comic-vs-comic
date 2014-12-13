var Router = Backbone.Router.extend({
	initialize: function(options){
		this.collection = options.collection;
		this.$el = options.$el;
	},
	routes: {
		"characters" : "index",
	},
	setView: function(view){
		if (this.view){
			this.view.remove();
			this.view = null;
		}
		this.view = view;
		this.$el.html(this.view.render().$el);
	},
	index: function(){
		var view = new CharacterListView({collection: this.collection});
		this.setView(view);
	},
});