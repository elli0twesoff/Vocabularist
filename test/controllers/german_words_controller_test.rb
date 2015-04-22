require 'test_helper'

class GermanWordsControllerTest < ActionController::TestCase
  setup do
    @german_word = german_words(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:german_words)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create german_word" do
    assert_difference('GermanWord.count') do
      post :create, german_word: { article: @german_word.article, english_word_id: @german_word.english_word_id, gender: @german_word.gender, word: @german_word.word }
    end

    assert_redirected_to german_word_path(assigns(:german_word))
  end

  test "should show german_word" do
    get :show, id: @german_word
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @german_word
    assert_response :success
  end

  test "should update german_word" do
    patch :update, id: @german_word, german_word: { article: @german_word.article, english_word_id: @german_word.english_word_id, gender: @german_word.gender, word: @german_word.word }
    assert_redirected_to german_word_path(assigns(:german_word))
  end

  test "should destroy german_word" do
    assert_difference('GermanWord.count', -1) do
      delete :destroy, id: @german_word
    end

    assert_redirected_to german_words_path
  end
end
