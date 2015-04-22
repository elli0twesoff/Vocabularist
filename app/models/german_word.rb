class GermanWord < ActiveRecord::Base
	belongs_to :english_word
	has_many :plurals
end
