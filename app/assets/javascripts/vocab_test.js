$(document).ready(function() {

	function getRandomArbitrary(min, max) {
    return Math.round(Math.random() * (max - min) + min);
	}

	function findPlural(germanObj, gender); {
		for (var i in germanObj['plurals']) {
			var pluralObj = germanObj['plurals'][i];
			if (pluralObj['gender'] == gender) {
				return pluralObj;
			}
		}
	}

	$("#next_ques").click(function() {
		var remainingWords = JSON.parse($("#quiz_words").attr('data-json'));
		var nextWord = JSON.parse(remainingWords[0]);
		var english = nextWord['english']['word'];
		var randNum = getRandomArbitrary(0, nextWord['german'].length - 1);
		var germanObj = nextWord['german'][randNum];
		var germanWord = germanObj['word'];
		var germanArt = germanObj['article'];
		var gender = germanObj['gender'];
		var plural = findPlural(germanObj, gender);
		var pluralWord = plural['word'];
		var pluralArt = plural['article'];

	});

});
