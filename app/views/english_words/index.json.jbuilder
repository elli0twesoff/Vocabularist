json.array!(@english_words) do |english_word|
  json.extract! english_word, :id, :word, :chapter
  json.url english_word_url(english_word, format: :json)
end
