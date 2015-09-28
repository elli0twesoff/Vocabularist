class VocabTestsController < ApplicationController
  def start
    if params[:chapters]
      if params[:commit] == 'start'
        if authenticated?
          params[:chapters].each do |chap|
            if chap.to_i > 1
              if current_user && !current_user.activated
                redirect_to root_path, alert: "You are registered and signed in, but you need to pay before you can use chapters beyond Chapter 1. #{view_context.link_to('Pay here', payment_path)}."
              else
                redirect_to root_path, alert: "Please sign in with an activated account to use chapters beyond Chapter 1. Thank you."
              end
            end
          end
        end

        @words = EnglishWord.get_test_words(params)
        @words_json = EnglishWord.get_json_words(@words)

      else
        redirect_to root_path, alert: 'hmmm......'
      end
    else
      redirect_to root_path, alert: 'You need to select at least one chapter to be tested on!'
    end
  end
end
