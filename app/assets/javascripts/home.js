function showAllCharacters(){
	var characterCollection = new CharacterCollection();

	characterCollection.fetch({
		success: function(characters) {
			characterListView = new CharacterListView({collection: characters });
		}
	});
	Backbone.history.start();
}

function minimizeOpponentHealth(type, damage){
	var currentHealth = parseInt($('#opponent-health-meter').css("width").replace("px",""));
	var minusDamage = damage * 25;
	var changeHealth = currentHealth - minusDamage;
	if (type === "hit"){
		$('#opponent-health-meter').css("width", changeHealth+"px")
	}
}

function minimizeCharacterHealth(type, damage){
	debugger;
	var currentHealth = parseInt($('#character-health-meter').css("width").replace("px",""));
	var minusDamage = damage * 25;
	var changeHealth = currentHealth - minusDamage;
	if (type === "hit"){
		$('#character-health-meter').css("width", changeHealth+"px")
	}
}

function reactionToOpponent(){
	console.log('reaction')
	$.ajax({
		url: '/reaction-to-opponent',
		dataType: 'json',
		success: function(data){
			console.log(data);
			debugger;
			var type = data.value.type
			var damage = data.value.damage

			var template = _.template($('#story-template').html());
			var renderedHtml = template(data.value);
			$('#story-results').prepend(renderedHtml);

			setTimeout(function () {
				minimizeCharacterHealth(type,damage);
			}, 1000);

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
			debugger;
			var type = data.value.type
			var damage = data.value.damage
			var template = _.template($('#story-template').html());
			var renderedHtml = template(data.value);
			$('#story-results').prepend(renderedHtml);
			
			setTimeout(function () {
			    opponentPower();
			    minimizeOpponentHealth(type, damage);
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
			$('#story-text').css("border","orange 2px solid");
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
			$('#story-text').css("border","green 2px solid");
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
			$('#story-text').css("border","blue 2px solid");
						
			$('#opponent_skull').css('left', data.opponent_damage);

			setTimeout(function () {
			    addReaction();
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





