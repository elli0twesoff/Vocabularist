json.array!(@german_words) do |german_word|
  json.extract! german_word, :id, :word, :article, :gender, :english_word_id
  json.url german_word_url(german_word, format: :json)
end
