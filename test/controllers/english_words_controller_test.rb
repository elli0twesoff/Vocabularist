require 'test_helper'

class EnglishWordsControllerTest < ActionController::TestCase
  setup do
    @english_word = english_words(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:english_words)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create english_word" do
    assert_difference('EnglishWord.count') do
      post :create, english_word: { chapter: @english_word.chapter, word: @english_word.word }
    end

    assert_redirected_to english_word_path(assigns(:english_word))
  end

  test "should show english_word" do
    get :show, id: @english_word
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @english_word
    assert_response :success
  end

  test "should update english_word" do
    patch :update, id: @english_word, english_word: { chapter: @english_word.chapter, word: @english_word.word }
    assert_redirected_to english_word_path(assigns(:english_word))
  end

  test "should destroy english_word" do
    assert_difference('EnglishWord.count', -1) do
      delete :destroy, id: @english_word
    end

    assert_redirected_to english_words_path
  end
end
