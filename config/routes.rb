Rails.application.routes.draw do

  resources :payments

  devise_for :users
  resources :german_words
  resources :english_words

	post 'vocab_tests/start', to: 'vocab_tests#start'
	post 'vocab_tests/complete_test', to: 'vocab_tests#complete_test'

  root 'home#index'

end
