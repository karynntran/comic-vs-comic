console.log(':)')

function searchCharacter(){
	console.log('search character OK')
	$.ajax({
		url: "/search",
		method: "GET",  
		dataType: "json",
		success: function(data) {
			displayCharacter(character);
		}
	})
}

function displayCharacterStats(character){

}

$(function(){

});