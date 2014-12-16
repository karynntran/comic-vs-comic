
function showAllCharacters(){
	var characterCollection = new CharacterCollection();

	characterCollection.fetch({
		success: function(characters) {
			characterListView = new CharacterListView({collection: characters });
		}
	});
	Backbone.history.start();
}

function minimizeOpponentHealth(){
	var currentHealth = parseInt($('#opponent-health-meter').css("width").replace("px",""));
	var minusTen = currentHealth - 25;
	$('#opponent-health-meter').css("width", minusTen+"px")
}

function minimizeCharacterHealth(){
	var currentHealth = parseInt($('#character-health-meter').css("width").replace("px",""));
	var minusTen = currentHealth - 25;
	$('#character-health-meter').css("width", minusTen+"px")
}

function reactionToOpponent(){
	console.log('reaction')
	$.ajax({
		url: '/reaction-to-opponent',
		dataType: 'json',
		success: function(data){
			console.log(data);
			var template = _.template($('#story-template').html());
			var renderedHtml = template(data.value);
			$('#story-results').prepend(renderedHtml);
		}
	})
}

function opponentPower(){
	console.log('reaction')
	$.ajax({
		url: '/opponent-power',
		dataType: 'json',
		success: function(data){
			console.log(data);
			var template = _.template($('#story-template').html());
			var renderedHtml = template(data.value);
			$('#story-results').prepend(renderedHtml);

			setTimeout(function () {
			    reactionToOpponent();
				minimizeCharacterHealth();
			}, 1000);

		}
	})
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
			$('#story-results').prepend(renderedHtml);
			
			setTimeout(function () {
			    opponentPower();
			}, 1000);

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
			$('#story-results').prepend(renderedHtml);
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
			$('#story-results').prepend(renderedHtml);
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
			$('#story-results').prepend(renderedHtml);
			$('#story-text').css("border","yellow 2px solid");
						
			setTimeout(function () {
			    addReaction();
			    minimizeOpponentHealth();
			}, 2000);
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
	$('#all-chars').on('click',  function(e){
		e.preventDefault();
		showAllCharacters();
	})

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





;
