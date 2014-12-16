// var CharacterListView = Backbone.View.extend({
//   tagName: 'ul',
//   el: '#character-index',
//   template: _.template($('#character-list-item-template').html()),
//   render: function() {
//     this.$el.html("");
//     var renderedHTML = this.template({collection: this.collection});
//     this.$el.html(renderedHTML);
//     return this;
//   }
// });
console.log('...character list view');

var CharacterListView = Backbone.View.extend({

  el: $('.characters'),

  initialize: function(){
    console.log('hey');
    this.render();
  },

  render: function(){
    this.$el.empty();
    this.collection.models.forEach(function(model){
      var modelView = new CharacterView({model: model});
      this.$el.append(modelView.render().$el);
    }.bind(this))
  }
})