// function ZapBoomOrPow(){
// 	var hitPics = new Array("/assets/zap.png","/assets/bang.png","/assets/pow.png");
// 	function choosePic() {
// 	randomNum = Math.floor((Math.random() * hitPics.length));
// 	document.getElementById("myPicture").src = myPix[randomNum];
// }

// function setView(newView) {
// 	if (this.view) {
// 	  this.view.remove();
// 	}
// 	this.view = newView;
// 	this.view.render().$el.appendTo('#game-area');
// }


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

function showWinner(winner){
	var div = document.createElement('div');
	var text = document.createTextNode(winner);
	div.appendChild(text);
	$('#game-area').append(div);
	$(div).css({
    'background-color':'lightgray',
    'height':'300px',
    'width':'80%',
    'margin':'50px auto',
    'font-size':'40px',
    'font-family':'Permanent Marker',
    'border-radius':'50px',
    'position':'absolute',
    'top': '28%',
    'left': '12%',
    'opacity': '.9',
    'text-align':'center',
	'color': 'red',
	});
	$(text).css({
		'opacity': '1',
		'vertical-align':'middle'
	})
}

function minimizeOpponentHealth(type, damage, outcome){
	// var currentHealth = parseInt($('#opponent-health-meter').css("width").replace("px",""));
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
	// var currentHealth = parseInt($('#character-health-meter').css("width").replace("px",""));
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

			var template = _.template($('#story-template').html());
			var renderedHtml = template(data.value);
			$('#story-results').prepend(renderedHtml);

			setTimeout(function () {
				minimizeCharacterHealth(type,damage,outcome);
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
			var type = data.value.type
			var damage = data.value.damage
			var outcome = data.value.outcome

			var template = _.template($('#story-template').html());
			var renderedHtml = template(data.value);
			$('#story-results').prepend(renderedHtml);
			
			setTimeout(function () {
			    opponentPower();
			    minimizeOpponentHealth(type, damage,outcome);
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
			$('#story-text').toggle("pulsate", 1200);
						
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

function removeIntro(){
	$('#welcome').css('display','none');
}

$(function(){

	$('#welcome').show();

	$("#play").click(function() {
	$('#welcome').toggle('slide', { direction: 'up' }, 500);
		removeIntro();
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





