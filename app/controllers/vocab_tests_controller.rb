class VocabTestsController < ApplicationController
  def start
		if params[:chapters]
			if params[:commit] == 'start'

				@words = EnglishWord.get_test_words(params)
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
