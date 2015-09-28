Rails.application.routes.draw do

  #resources :payments
  get 'german_words/load_from_file', to: 'german_words#load_from_file'
  put 'german_words/update_words', to: 'german_words#update_words'
	post 'vocab_tests/start', to: 'vocab_tests#start'
	post 'vocab_tests/complete_test', to: 'vocab_tests#complete_test'
  get 'payments/new', to: 'payments#new', as: 'subscribe'

  devise_for :users, controllers: {
    registrations: "users/registrations"
  }

  devise_scope :user do
    post 'pay' => 'users/registrations#create', as: 'payment'
  end

  resources :german_words
  resources :english_words

  root 'home#index'

end
