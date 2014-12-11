// console.log(':)')

// var character = new Character(), router;
// chracter.fetch().done(function(){
// 	router = new Router({
// 		model: character,
// 		$el: $()
// 	})
// })

// Backbone.history.start();



$(function(){

	$('form').on('submit', function(e){
		e.preventDefault();
		var name = $('form').find('input[name="query"]').val();
		$.ajax({
			url: '/search',
			data: {query: name},
			success: function(data){
				console.log(data)

				if (data.name){
					var template = _.template($('#result-template').html());
					var renderedHtml = template(data);
					$('.chosen-character').html(renderedHtml);

					$('.chosen-character').find('.character-action').on('click',  function(e){
						console.log($(this));
					})

				}
			}
		})

	})

})





