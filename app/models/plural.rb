class Plural < ActiveRecord::Base
	belongs_to :english_word
	belongs_to :german_word
end
