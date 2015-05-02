class EnglishWord < ActiveRecord::Base
	has_many :german_words, dependent: :destroy
	has_many :plurals, dependent: :destroy

	def create_translations(params)
		#  this is probably real disgusting but i'm super fuckin burnt out n tird rn so
		#  don't fucking judge me bitch.  fuck off.

		if !params[:non_noun].blank?
			@non_noun = german_words.create(word: params[:non_noun], article: '', gender: '')
		else
			if !params[:singular].blank?
				params[:singular_art].blank? ? ms_art = 'der' : ms_art = params[:singular_art]
				@singular = german_words.create(word: params[:singular], article: ms_art, gender: 'singular')

				if !params[:plural].blank?
					params[:plural_art].blank? ? plural_art = 'die' : plural_art = params[:plural_art]
					@singular.plurals.create(word: params[:plural], article: plural_art, gender: 'plural')
				end
			end

			if !params[:fem_sing].blank?
				params[:fem_sing_art].blank? ? fs_art = 'die' : fs_art = params[:fem_sing_art]
				@fem_sing = german_words.create(word: params[:fem_sing], article: fs_art, gender: 'feminine singular')

				if !params[:fem_plur].blank?
					params[:fem_plur_art].blank? ? fp_art = 'die' : fp_art = params[:fem_plur_art]
					@fem_sing.plurals.create(word: params[:fem_plur], article: fp_art, gender: 'feminine plural')
				end
			end
		end

		{ masc: @singular, fem: @fem_sing, neu: @neu_sing }
	end

	def self.get_json_words(words)
		word_hash = []

		words.each do |word|

			deutsches_wortes = word.german_words
			plurals = []

			deutsches_wortes.each do |wort|
				wort.plurals.each do |plural|
					plurals << plural
				end
			end

			word_hash << { english: word, german: deutsches_wortes, plurals: plurals }.to_json
		end

		word_hash
	end

	def self.get_test_words(params)
		# collect english words here...
		
		chapters = params[:chapters]
		words = []

		chapters.each do |ch|
			if params[:nouns_only]
				GermanWord.all.nouns.each { |wort| words << wort.english_word }
				#words << EnglishWord.joins(:german_words).where("german_words.gender != ''", "chapter = #{ch.to_i}")
			else
				words << EnglishWord.where(chapter: ch.to_i) 
			end
		end

		words = words.flatten.uniq.shuffle!

		unless params[:question_limit].blank? && words.length > params[:question_limit].to_i
			words = words.drop(words.length - params[:question_limit].to_i)
		end

		return words
	end

	private

	def self.nuke!
		# FUCK YO COUCH CUHHH
		EnglishWord.destroy_all
		puts "destroyed all words."
	end
end
