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

function callFriends(){
	console.log('call friends')
	$.ajax({
		url: '/call-friends',
		dataType: 'json',
		success: function(data){
			console.log(data);
			var template = _.template($('#story-template').html());
			debugger;
			var renderedHtml = template(data.value);
			$('.story-results').append(renderedHtml);
		}
	})
}
function showPower(){
	console.log('show power')
	$.ajax({
		url: '/power',
		dataType: 'json',
		success: function(data){
			console.log(data);
			var template = _.template($('#story-template').html());
			debugger;
			var renderedHtml = template(data.value);
			$('.story-results').append(renderedHtml);
		}
	})
}

function showOpponent(){
	console.log('show opponent')
	$.ajax({
		url: '/opponent',
		method: 'GET', 
		data: {opponent: name},
		dataType: 'json',
		success: function(data){
			var template = _.template($('#opponent-template').html());
			var renderedHtml = template(data);
			$('.opponent-character').html(renderedHtml);
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
						e.preventDefault();
						console.log($(this));
						showPower();
						// callFriends();
					})

				}
			}
		})

	})

})





