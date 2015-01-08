function chooseMove(){
	var div = document.createElement('div');
	var text = document.createTextNode('Make A Move!');
	div.appendChild(text);
	$('#story-results').prepend(div);
	$(div).css({
	    'background-color':'lightgray',
	    'text-align':'center',
	    'font-size':'30px',
		'color': 'red',
		'border-radius': '10px',
		'border': 'red 2px dashed',
		'margin': '20px',
	});
}

function showAllCharacters(){
	var characterCollection = new CharacterCollection();

	characterCollection.fetch({
		success: function(characters) {
			characterListView = new CharacterListView({collection: characters, el: $('#game-area') });
			characterListView.render()
		}
	});
	Backbone.history.start();
}

// function showWinner(winner){
// 	var div = document.createElement('div');
// 	var text = document.createTextNode(winner);
// 	div.appendChild(text);
// 	$('#game-area').append(div);
// 	$(div).css({
// 	    'background-color':'lightgray',
// 	    'height':'300px',
// 	    'width':'80%',
// 	    'margin':'50px auto',
// 	    'font-size':'40px',
// 	    'font-family':'Permanent Marker',
// 	    'border-radius':'50px',
// 	    'position':'absolute',
// 	    'top': '28%',
// 	    'left': '12%',
// 	    'opacity': '.9',
// 	    'text-align':'center',
// 		'color': 'red',
// 	});
// 	$(text).css({
// 		'opacity': '1',
// 		'vertical-align':'middle'
// 	})
// 	$('#game-area').clearQueue();
// 	$('body').clearQueue();
// }

function showWinner(winner){
	debugger;
	var text = document.createTextNode("" + winner.name + " wins!");
	var image =document.createElement("img");
	$(image).attr({"src": winner.image, "width": "100px", "height": "auto"});

	$("#winner-name").append(text);
	$("#winner-image").append(image);
	$("#winner-results").show();

	// $('#game-area').hide();

	$('#game-area').clearQueue();
	$('body').clearQueue();
}

function minimizeOpponentHealth(type, damage, outcome){
	var totalHealth = 250;
	var minusDamage = damage * 50;
	var changeHealth = totalHealth - minusDamage;
	if (type === "hit"){
		$('#opponent-health-meter').css("width", changeHealth+"px")
	}
	if (outcome !== "none"){
		showWinner(outcome);
	}
}

function minimizeCharacterHealth(type, damage, outcome){

	var totalHealth = 250;
	var minusDamage = damage * 50;
	var changeHealth = totalHealth - minusDamage;
	if (type === "hit"){
		$('#character-health-meter').css("width", changeHealth+"px")
	}
	if (outcome !== "none"){
		showWinner(outcome);
	}
}

function reactionToOpponent(){
	console.log('reaction')
	$.ajax({
		url: '/reaction-to-opponent',
		dataType: 'json',
		success: function(data){
			console.log(data);
			var type = data.value.type
			var damage = data.value.damage
			var outcome = data.value.outcome
			var image = data.value.image

			var template = _.template($('#story-template').html());
			var renderedHtml = template(data.value);
			$('#story-results').prepend(renderedHtml);
			$('#story-text').effect( "bounce", "slow" );

			minimizeCharacterHealth(type,damage,outcome,image);

			setTimeout(function () {
				chooseMove();
			}, 3000);
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
			$('#story-text').animate({
			    outlineColor: "#CC0000"
			});
			
			setTimeout(function () {
			    reactionToOpponent();
			}, 2000);

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
			var type = data.value.type
			var damage = data.value.damage
			var outcome = data.value.outcome
			var image = data.value.image

			var template = _.template($('#story-template').html());
			var renderedHtml = template(data.value);
			$('#story-results').prepend(renderedHtml);
			$('#story-text').effect( "bounce", "slow" );

			minimizeOpponentHealth(type,damage,outcome,image);

			setTimeout(function () {
			    opponentPower();
			}, 2000);
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
			$('#story-text').animate({
			    color: "white",
			    backgroundColor: "#CC9900"
			});

			setTimeout(function () {
			    addReaction();
			}, 2000);
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
			$('#story-text').animate({
			    color: "white",
			    backgroundColor: "#009933"
			});
			setTimeout(function () {
				chooseMove();
			}, 3000);
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
			$('#story-text').animate({
			    color: "white",
			    backgroundColor: "#0033CC"
			  });

			// $('#opponent_skull').css('left', data.opponent_damage);

			setTimeout(function () {
			    addReaction();
			}, 2000);
		}
	})
}

function showOpponent(){
	console.log('show opponent')
	$.ajax({
		url: '/stories/:id/opponent',
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
	$("#play").click(function() {
		$('#welcome').toggle('slide', { direction: 'up' }, 500);
	});
	
	$('#zap').delay(500).fadeIn();
	$('#bang').delay(750).fadeIn();
	$('#pow').delay(1000).fadeIn();
	

	$('#all-chars').on('click',  function(e){
		e.preventDefault();
		showAllCharacters();
	})

	$('#search').on('submit', function(e){
		e.preventDefault();
		var name = $('form').find('input[name="query"]').val();
		$.ajax({
			url: '/stories',
			method: 'POST',
			data: {query: name},
			success: function(data){				
				console.log(data);
				var new_game = data;
				if (new_game === null) {
					var renderedHtml = "Character not found. Search again!";
					$('#search-error').html(renderedHtml);	
					// $('#content').empty();
					// $('#buttons').empty();		
				} else {
					$('#search-error').empty();
					var template = _.template($('#result-template').html());
					var renderedHtml = template(new_game);
					$('#chosen-character').html(renderedHtml);

					showOpponent();
					$('#story-results').empty();
					$('#story-results').show();

					$('#buttons').show();
				};
			}
		})
	})


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


})





