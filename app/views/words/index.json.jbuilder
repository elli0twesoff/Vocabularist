json.array!(@words) do |word|
  json.extract! word, :id, :english, :german, :chapter, :article, :gender, :plural_key
  json.url word_url(word, format: :json)
end
