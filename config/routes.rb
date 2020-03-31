Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post '/signup',to: 'users#create'
  post '/login',to: 'users#login'
  get '/user/data', to: 'users#data'
  post '/user/update/', to: 'users#update',as: 'update'
  post '/create_question', to: 'users#create_question'

  get '/question',to: 'questions#data'
  get '/questions', to: 'questions#index'
  get '/answers_from_question', to: 'answers#answers_from_question'
  get '/comments_from_question', to: 'comments#comments_from_question'

  post "/create_answer",to: 'answers#create'

  post "/create_comment",to: 'comments#create'

  post "/create_vote",to: 'votes#create'
  post "/update_vote",to: 'votes#update'
  post "/delete_vote",to: 'votes#destroy'

end
