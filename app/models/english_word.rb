class EnglishWord < ActiveRecord::Base
	has_many :german_words, dependent: :destroy

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
