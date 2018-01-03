Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  resources :posts
  get '/api/posts' => 'api_posts#index', :defaults => { :format => :json }
  get '/api/posts/:id' => 'api_posts#show', :defaults => { :format => :json }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
