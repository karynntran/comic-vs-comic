// AJAX CALL FROM SEE ALL CHARACTERS LINK
// BACKBONE SCRIPTS

// // <script>
// 	var characterCollection = new CharacterCollection(),
// 		router;	
// 	characterCollection.fetch().done(function(){
// 		router = new Router({
// 			collection: characterCollection, 
// 			$el: $('.character-index')
// 		});
// 		Backbone.history.start();
// 	});
// // </script>


var characterCollection = new CharacterCollection();

characterCollection.fetch().done(function(){
	var characterRouter = new Router({
  		collection: characterCollection
	});
});
Backbone.history.start();

// function seeAllCharacters(){
// 	$.ajax({
// 		url: '/characters',
// 		dataType: 'json',
// 		success: function(data){

// 		}
// 	})
// }

function minimizeHealth(){
	var currentHealth = parseInt($('#opponent-health-meter').css("width").replace("px",""));
	var minusTen = currentHealth - 25;
	$('#opponent-health-meter').css("width", minusTen+"px")
}

function addReaction(){
	console.log('reaction')
	$.ajax({
		url: '/reaction',
		dataType: 'json',
		success: function(data){
			console.log(data);
			var template = _.template($('#story-template').html());
			var renderedHtml = template(data.value);
			$('#story-results').append(renderedHtml);
		}
	})
}

function helpOut(){
	console.log('help out')
	$.ajax({
		url: '/help-out',
		dataType: 'json',
		success: function(data){
			console.log(data);
			var template = _.template($('#story-template').html());
			var renderedHtml = template(data.value);
			$('#story-results').append(renderedHtml);
			addReaction();
		}
	})
}

function callFriends(){
	console.log('call friends')
	$.ajax({
		url: '/call-friends',
		dataType: 'json',
		success: function(data){
			console.log(data);
			var template = _.template($('#story-template').html());
			var renderedHtml = template(data.value);
			$('#story-results').append(renderedHtml);
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
			var renderedHtml = template(data.value);
			$('#story-results').append(renderedHtml);
			addReaction();
			minimizeHealth();
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
			$('#opponent-character').html(renderedHtml);
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
					$('#chosen-character').html(renderedHtml);
				};
				showOpponent();
				$('#story-results').empty();
				$('#story-results').show();

				$('#buttons').show();

				$('#power-button').on('click',  function(e){
					e.preventDefault();
					console.log($(this));
					showPower();
				});

				$('#friend-button').on('click',  function(e){
					e.preventDefault();
					console.log($(this));
					callFriends();
				})

				$('#help-out-button').on('click',  function(e){
					e.preventDefault();
					console.log($(this));
					helpOut();
				})

			}
		})
	})
})





