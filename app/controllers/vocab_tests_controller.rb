class VocabTestsController < ApplicationController
  def start
		if params[:chapters]
			chapters = params[:chapters]

			if params[:commit] == 'english'
				# collect english words here...
			elsif params[:commit] == 'deutsch'
				# collect german words here...
			else
				redirect_to root_path, alert: 'hmmm......'
			end

		else
			redirect_to root_path, alert: 'you need to select at least one chapter to be tested on!'
		end

		# for now redirect to the home page.  we'll redirect to a results page
		# once we get it built.
		redirect_to root_path
  end
end
