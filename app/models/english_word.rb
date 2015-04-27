class EnglishWord < ActiveRecord::Base
	has_many :german_words, dependent: :destroy
	has_many :plurals, dependent: :destroy

	def create_translations(params)
		#  this gets called from the controller btw...
		#
		#  this is probably real disgusting but i'm super fuckin burnt out n tird rn so
		#  don't fucking judge me bitch.  fuck off.
		
		if !params[:masc_sing].blank?

			params[:masc_sing_art].blank? ? ms_art = 'der' : ms_art = params[:mas_sing_art]
			@masc_sing = german_words.create(word: params[:masc_sing], article: ms_art, gender: 'ms')

		  if !params[:masc_plur].blank?

				params[:masc_plur_art].blank? ? mp_art = 'die' : mp_art = params[:masc_plur_art]
				masc_sing.plurals.create(word: params[:masc_plur], article: mp_art, gender: 'mp')

			end

		elsif !params[:fem_sing].blank?

			params[:fem_sing_art].blank ? fs_art = 'die' : ms_art = params[:fem_sing_art]
			@fem_sing = german_words.create(word: params[:fem_sing], article: fs_art, gender: 'fs')

			if !params[:fem_plur].blank?
				params[:fem_plur_art].blank? ? fp_art = 'die' : fp_art = params[:fem_plur_art]
				fem_sing.plurals.create(word: params[:fem_plur], article: fp_art, gender: 'fp')
			end

		end

		{ masc: @masc_sing, fem: @fem_sing }
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

	private

	def self.nuke!
		EnglishWord.destroy_all
		# consequently destroys all german words 
		# and their plurals.
		
		puts "destroyed all words."
	end
end
