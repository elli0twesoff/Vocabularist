class GermanWordsController < ApplicationController
  before_action :set_german_word, only: [:show, :edit, :update, :destroy]

  # GET /german_words
  # GET /german_words.json
  def index
    @german_words = GermanWord.all
  end

  # GET /german_words/1
  # GET /german_words/1.json
  def show
  end

  # GET /german_words/new
  def new
    @german_word = GermanWord.new
  end

  # GET /german_words/1/edit
  def edit
  end

  # POST /german_words
  # POST /german_words.json
  def create
    @german_word = GermanWord.new(german_word_params)

    respond_to do |format|
      if @german_word.save
        format.html { redirect_to @german_word, notice: 'German word was successfully created.' }
        format.json { render :show, status: :created, location: @german_word }
      else
        format.html { render :new }
        format.json { render json: @german_word.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /german_words/1
  # PATCH/PUT /german_words/1.json
  def update
    respond_to do |format|
      if @german_word.update(german_word_params)
        format.html { redirect_to @german_word, notice: 'German word was successfully updated.' }
        format.json { render :show, status: :ok, location: @german_word }
      else
        format.html { render :edit }
        format.json { render json: @german_word.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /german_words/1
  # DELETE /german_words/1.json
  def destroy
    @german_word.destroy
    respond_to do |format|
      format.html { redirect_to german_words_url, notice: 'German word was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def load_from_file
    @file_data = File.open("word_lists/1-de.json", "r").read
  end

  def update_words
    words = JSON.parse(params[:word_data])
    GermanWord.update_words(words)
    redirect_to :back, flash: { success: "Successfully updated words." }

  rescue Exception => e
    redirect_to :back, flash: { warning: e.message }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_german_word
      @german_word = GermanWord.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def german_word_params
      params.require(:german_word).permit(:word, :article, :gender, :english_word_id)
    end
end
