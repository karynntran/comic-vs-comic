
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