var answer = {};
var score = 0;


function getRandomArbitrary(min, max) {
	return Math.round(Math.random() * (max - min) + min);
}

function findPlural(pluralsArray, gender) {
	for (var i in pluralsArray['plurals']) {
		var pluralObj = germanObj['plurals'][i];
		if (pluralObj['gender'] == gender) {
			return pluralObj;
		}
	}
}

function checkAnswer(answer) {
	var userArt = $("#german_article").val();
	var userWord = $("#german_word").val();

	if (userWord.length > 0) {
		if (userArt == answer['article'] && userWord == answer['word']) {
			score++;
			alert('yes!');
		} else {
			alert('nope :/  the answer is ' + answer['article'] + ' ' + answer['word']);
		}
	}
}

$(document).ready(function() {

	$("#next_ques").click(function() {
		// check to see if what the user entered was correct!
		checkAnswer(answer);
		
		// parse the data out of the div element we're storing our words
		// in. there's probably a better way to do this, but i'm a JS noob
		// so whatever man.
		
		var remainingWords = JSON.parse($("#quiz_words").attr('data-json'));

		// parse and remove the upcoming word from our word list array.
		var nextWord = JSON.parse(remainingWords.shift());
		var english = nextWord['english']['word'];
		var randNum = getRandomArbitrary(0, nextWord['german'].length - 1);
		var germanObj = nextWord['german'][randNum];
		var germanWord = germanObj['word'];
		var germanArt = germanObj['article'];
		var gender = germanObj['gender'];
		var plural = findPlural(nextWord['plurals'], gender);
		var wordSelector = getRandomArbitrary(0, 1);

		if (plural != null) {
			var pluralWord = plural['word'];
			var pluralArt = plural['article'];
		}

		if (wordSelector == 0) {
			// give the user a singular word.
			answer['article'] = germanArt;
			answer['word'] = germanWord;
		} else {
			// give the user a plural word.
			answer['article'] = pluralArt;
			answer['word'] = pluralWord;
		}
		// set the new values to their proper div elements.

		$("#english").html(english);
		//$("#german_article").html(germanArt);
		//$("#german_word").html(germanWord);

		// don't forget to reset the value in the quiz_words div, so
		// we don't do the same question over and over again ;)
		$("#quiz_words").attr("data-json", JSON.stringify(remainingWords));	

	});

	$("#next_ques").click();

});
