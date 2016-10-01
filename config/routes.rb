Rails.application.routes.draw do
  g
  devise_for :users

  get '/' => 'application#index'
  get '/account' => 'users#show', as: 'account'
  get 'designs' => 'designs#designs', as: 'designs'
  get 'designer/:id' => 'designs#designer', as: 'designer'
  post 'designs' => 'designs#create'

  get 'designs/gender' => 'designs#filter_gender'
  get 'designs/:gender' => 'designs#filter_season'

    get 'designs/:gender/:season' => 'designs#filter', as: 'filter'

  mount Commontator::Engine => '/commontator'

  delete 'design/:id/delete' => "designs#destroy", as: 'destroy_design'


  resources :designs , path: 'design', except: [:index]
  put	'/design/:id/like' =>	'designs#upvote', as: 'like'
  put	'/design/:id/dislike' => 'designs#downvote', as: 'dislike'
end
