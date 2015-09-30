class GermanWord < ActiveRecord::Base
	belongs_to :english_word
	has_many :plurals

	scope :nouns, -> { where("gender != ''") }

  def self.update_words(words)
    
    GermanWord.all.each do |de|
      # the dependent: :destroy was giving weird errors, so we
      # have to do this stupid shit.
      # we're loading them all back into the database anyways, so whatevs.
      de.plurals.destroy_all
      de.destroy
    end

    words.keys.each do |word|
      words[word].each do |translation|
        en = EnglishWord.find_or_create_by(word: word, chapter: translation['chapter'])

        new_deutsch = en.german_words.create(
              word: translation['word'],
           article: translation['article'],
            gender: translation['gender']
        )

        if translation['plural']
          plural = translation['plural']
          
          new_deutsch.plurals.create(
                   article: plural['article'],
                      word: plural['word'],
                    gender: plural['gender'],
           english_word_id: en.id
          )
        end
      end
    end
  rescue Exception => e
    raise Exception, "Couldn't update words: #{e.message}"
  end
end
