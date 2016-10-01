Rails.application.routes.draw do
  devise_for :users

  get '/' => 'application#index'

  mount Commontator::Engine => '/commontator'

  resources :designs , path: 'design', except: [:index]
  put	'/design/:id/like' =>	'designs#upvote', as: 'like'
  put	'/design/:id/dislike' => 'designs#downvote', as: 'dislike'
end
