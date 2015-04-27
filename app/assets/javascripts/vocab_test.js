var answer = {};
var score = 0;
var remainingWords;


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

function checkAnswer(userArt, userWord) {

	if (userArt == answer['article'] && userWord == answer['word']) {
		score++;
		alert('yes!');
	} else {
		alert('nope :/  the answer is ' + answer['article'] + ' ' + answer['word']);
	}

}

function generateNextWord() {

	// parse and remove the upcoming word from our word list array.
	var nextWord = JSON.parse(remainingWords.shift());
	var english = nextWord['english']['word'];
	var randNum = getRandomArbitrary(0, nextWord['german'].length - 1);
	var germanObj = nextWord['german'][randNum];
	var germanWord = germanObj['word'];
	var germanArt = germanObj['article'];
	var gender = germanObj['gender'];
	var plural = findPlural(nextWord['plurals'], gender);
	var wordSelector = 0;

	if (plural != null) {
		var pluralWord = plural['word'];
		var pluralArt = plural['article'];
		wordSelector = getRandomArbitrary(0, 1);
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

	// update the fields for the new word.
	$('#english').html(english);
	$('#gender').html(gender);
}

$(document).ready(function() {

	// parse the data out of the div element we're storing our words in.
	remainingWords = JSON.parse($('#quiz_words').attr('data-json'));
	var wordCount = remainingWords.length 

	// erase the word data from our html attribute so sneaky fuckers
	// like you can't cheat.
	$('#quiz_words').attr('data-json', '');

	$('#next_question').click(function() {
		// check to see if what the user entered was correct!
		var userArt = $('#german_article').val();
		var userWord = $('#german_word').val();
		
		if (userWord.length > 0) {
			checkAnswer(userArt, userWord);
			if (remainingWords.length > 0) {
				generateNextWord();
				$('#german_article').val('');
				$('#german_word').val('');
			} else {
				alert("that's all!  you got " + score + " out of " + wordCount + " correct!");
				window.location = '/';
			}

		} else {
			alert("at least try to guess or something...");
		}

	});

	generateNextWord();

});
