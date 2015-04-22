class EnglishWord < ActiveRecord::Base
	has_many :german_words, dependent: :destroy


	private

	def self.exterminate!
		EnglishWord.destroy_all
		puts "destroyed all words."
	end
end
