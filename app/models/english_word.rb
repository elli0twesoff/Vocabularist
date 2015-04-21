class EnglishWord < ActiveRecord::Base
	has_one :german_word, dependent: :destroy
end
