class EnglishWord < ActiveRecord::Base
	has_many :german_words
end
