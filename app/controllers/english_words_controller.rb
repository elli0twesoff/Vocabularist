class EnglishWordsController < ApplicationController
	#before_action :set_english_word, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

	def index
		@english_words = EnglishWord.all
	end

	def show
	end

	def new
		@english_word = EnglishWord.new
	end

	def edit
		@english_word = EnglishWord.find(params[:id])

		# take the old translations and store them so we don't
		# have to retype them into the form.
		@english_word.german_words.each do |wort|
			if wort.gender == 'singular'
				@singular = wort.word
			else
				@fem_sing = wort.word
			end

			wort.plurals.each do |plural|
				plural.gender == 'plural' ? @plural = plural.word : @fem_plur = plural.word
			end
		end

		# wipe out the old german words and plurals cause yo dumbass
		# messed them up before.
		@english_word.german_words.destroy_all
	end

	def create
		@english_word = EnglishWord.find_or_create_by(word: params[:english_word], chapter: params[:chapter].first)

		@english_word.create_translations(params)

		respond_to do |format|
			if @english_word.save
				format.html { redirect_to new_english_word_path, notice: "'#{@english_word.word}' and translations created successfully." }
				format.json { render :show, status: :created, location: @english_word }
			else
				format.html { redirect_to :back, alert: "there was a problem doing that..." }
				format.json { render json: @english_word.errors, status: :unprocessable_entity }
			end
		end
	end

	def update
		respond_to do |format|
			if @english_word.update(english_word_params)
				format.html { redirect_to @english_word, notice: 'English word was successfully updated.' }
				format.json { render :show, status: :ok, location: @english_word }
			else
				format.html { render :edit }
				format.json { render json: @english_word.errors, status: :unprocessable_entity }
			end
		end
	end

	def destroy
		@english_word.destroy
		respond_to do |format|
			format.html { redirect_to english_words_url, notice: 'English word was successfully destroyed.' }
			format.json { head :no_content }
		end
	end

	private
	# Use callbacks to share common setup or constraints between actions.
	def set_english_word
		@english_word = EnglishWord.find(params[:id])
	end

	# Never trust parameters from the scary internet, only allow the white list through.
	def english_word_params
		params.require(:english_word).permit(:word, :chapter)
	end

end
