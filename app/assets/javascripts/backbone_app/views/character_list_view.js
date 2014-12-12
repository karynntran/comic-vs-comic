var CharacterListView = Backbone.View.extend({
  tagName: 'ul',
  template: _.template($('#character-list-item-template').html()),
  render: function() {
    this.$el.html("");
    var renderedHTML = this.template({collection: this.collection});
    this.$el.html(renderedHTML);
    return this;
  }
});