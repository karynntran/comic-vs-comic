// console.log(':)')

// var character = new Character(), router;
// chracter.fetch().done(function(){
// 	router = new Router({
// 		model: character,
// 		$el: $()
// 	})
// })

// // Backbone.history.start();
// function startGame(){
// 	$.ajax({
// 		url: '/start_game',
// 		method: 'GET',
// 		dataType: 'json',
// 		success: function(data){
// 			var new_game = data;
// 		}
// 	})
// }

function showOpponent(){
	$.ajax({
		url: '/opponent',
		method: "GET",  
		dataType: "json",
		success: function(data){
			console.log(data);
			if (data.name) {
				var template = _.template($('#opponent-template').html());
				var renderedHtml = template(data);
				$('.opponent-character').html(renderedHtml);
			}
		}
	})
}

$(function(){

	$('#search').on('submit', function(e){
		e.preventDefault();
		var name = $('form').find('input[name="query"]').val();
		$.ajax({
			url: '/search',
			data: {query: name},
			success: function(data){
				console.log(data);

				if (data.name){
					var template = _.template($('#result-template').html());
					var renderedHtml = template(data);
					$('.chosen-character').html(renderedHtml);

					showOpponent();

					$('.chosen-character').find('.character-action').on('click',  function(e){
						console.log($(this));
					})

				}
			}
		})

	})

})





