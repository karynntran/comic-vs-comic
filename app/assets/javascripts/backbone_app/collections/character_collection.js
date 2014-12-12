console.log("character collection...");

var CharacterCollection = Backbone.Collection.extend({
	model: Character,
	url: '/characters'
});