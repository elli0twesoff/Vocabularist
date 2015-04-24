class VocabTestsController < ApplicationController
  def start
		if params[:chapters]
			chapters = params[:chapters]
			@words = []

			if params[:commit] == 'english'
				# collect english words here...
				
				chapters.each { |ch| @words << EnglishWord.where(chapter: ch.to_i) }
				@words.flatten!
				@words_json = EnglishWord.get_json_words(@words)

			elsif params[:commit] == 'deutsch'
				# collect german words here...
			else
				redirect_to root_path, alert: 'hmmm......'
			end

		else
			# for now redirect to the home page.  we'll redirect to a results page
			# once we get it built.
			redirect_to root_path, alert: 'you need to select at least one chapter to be tested on!'
		end
  end
end
