console.log('...character view');

var CharacterView = Backbone.View.extend({
    tagName: 'li',
    className: 'character-view',
    initialize: function(){
      console.log('sup')
      this.render();
    },
    template: _.template($('#character-list-item-template').html()),
    render: function(){
      this.$el.html(this.template(this.model.attributes));
      return this;
    }
});
