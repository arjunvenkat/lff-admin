Rails.application.routes.draw do
  devise_for :users
  resources :messages
  post '/new_message' => 'messages#create_from_lff_site', :defaults => { :format => :json }
  mount Ckeditor::Engine => '/ckeditor'
  root to: 'posts#index'
  resources :posts
  get '/api/posts' => 'api_posts#index', :defaults => { :format => :json }
  get '/api/posts/:id' => 'api_posts#show', :defaults => { :format => :json }
  get '/api/posts/:id' => 'api_posts#show', :defaults => { :format => :json }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
