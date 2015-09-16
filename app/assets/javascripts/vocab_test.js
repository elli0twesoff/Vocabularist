var answer = {};
var score = 0;
var remainingWords;
var wordCount;


function getRandomArbitrary(min, max) {
	return Math.round(Math.random() * (max - min) + min);
}

function checkAnswer(userArt, userWord) {
	// TODO: keep track of incorrectly answered words.  redirect user to
	// another page rather than to home page to display to them the words they
	// missed.

	if (userArt == answer['article'] && userWord == answer['word']) {
		score++;
		// TODO:
		// constant alerts are annoying. let's maybe put a green check
		// next to the next button or something so the user knows they
		// answered correctly?
	} else {
		// TODO:
		// let's make this an html notice as well.  any kind of popup notices
		// are annoying.  they're just ghetto n shit.
		alert('sorry, the answer is ' + answer['article'] + ' ' + answer['word'] + '.');
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
	var plural = nextWord['plurals'][getRandomArbitrary(0, nextWord['plurals'].length - 1)];
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
    gender = plural['gender'];
	}

	// update the fields for the new word.
	// TODO: we need a field to let the quizzee know if the word
	// belongs to a certain case or not. ex: mich, dich, etc.
	// are all for the accusative case.
	$('#english').html(english);
	$('#gender').html(gender);
	$('.question-count').html('words remaining: ' + remainingWords.length);
}

function nextQuestion() {
		var userArt = $('#german_article').val();
		var userWord = $('#german_word').val();
		
		if (userWord.length > 0) {
			// check to see if what the user entered was correct!
			checkAnswer(userArt, userWord);

			if (remainingWords.length > 0) {
				generateNextWord();
				$('#german_article').val('');
				$('#german_word').val('');

				if (answer['article'] != '') {
					$('#german_article')[0].focus();
				} else {
					$('#german_word')[0].focus();
				}
			} else {
				var percentage = Math.round((score / wordCount) * 100) + "%";
				alert("you're done!  you got " + score + " out of " + wordCount + " (" + percentage +"), correct.");
				window.location = '/';
			}

		} else {
			alert("at least try to guess or something...");
		}

}

$(document).ready(function() {

	// parse the data out of the div element we're storing our words in.
	remainingWords = $('#quiz_words').data('words');
	wordCount = remainingWords.length 

	generateNextWord();

});
