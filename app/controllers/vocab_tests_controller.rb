class VocabTestsController < ApplicationController
  def start
    if params[:chapters]
      if params[:commit] == 'start'

        if !current_user || !current_user.admin?
          params[:chapters].each do |chap|
            if chap.to_i > 1
              redirect_to root_path, notice: "please sign in with an activated account to use chapters beyond chapter 1. thank you."
            end
          end
        end

        @words = EnglishWord.get_test_words(params)
        @words_json = EnglishWord.get_json_words(@words)
      else
        redirect_to root_path, alert: 'hmmm......'
      end

    else

      redirect_to root_path, alert: 'you need to select at least one chapter to be tested on!'
    end
  end
end
