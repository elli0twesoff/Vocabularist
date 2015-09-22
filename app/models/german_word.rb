class GermanWord < ActiveRecord::Base
	belongs_to :english_word
	has_many :plurals

	scope :nouns, -> { where("gender != ''") }

  def self.update_words(words)
    
    # we're loading them all back into the database anyways, whatevs.
    GermanWord.destroy_all

    words.keys.each do |word|
      en = EnglishWord.find_or_create_by(word: word, chapter: words[word]['chapter'])

      new_deutsch = en.german_words.create(
            word: words[word]['word'],
         article: words[word]['article'],
          gender: words[word]['gender']
      )

      if words[word]['plural']
        plural = words[word]['plural']
        plural_art = plural['article']
        plural_word = plural['word']
        new_deutsch.plurals.create(
           article: plural_art,
              word: plural_word,
            gender: 'plural'
        )
      end
    end
  rescue Exception => e
    raise Exception, "Couldn't update words: #{e.message}"
  end
end
