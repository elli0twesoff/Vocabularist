Rails.application.routes.draw do

  root 'home#index'

  get 'german_words/load_from_file', to: 'german_words#load_from_file'
  put 'german_words/update_words', to: 'german_words#update_words'
	post 'vocab_tests/start', to: 'vocab_tests#start'
	post 'vocab_tests/complete_test', to: 'vocab_tests#complete_test'
  get 'pay', to: 'payments#new', as: 'payment'
  post 'pay' => 'payments#create', as: 'process_payment'
  get 'disclaimer', to: 'payments#disclaimer', as: 'disclaimer'

  devise_for :users, controllers: {
    registrations: "users/registrations"
  }

  resources :german_words
  resources :english_words

end
