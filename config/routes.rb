Rails.application.routes.draw do
  get 'daily_jobs/index'
  resources :jobs
  resources :customers
  resources :users, only: [:new, :create]

  get 'login', to: 'sessions#new'

  post 'login', to: 'sessions#create'

  get 'welcome', to: 'sessions#welcome'

  get 'home', to: 'sessions#home' 

  get '/daily_jobs' , to: 'daily_jobs#index', :as => 'daily_jobs'

  get '/yesterday_jobs' , to: 'yesterday_jobs#index', :as => 'yesterday_jobs'

  get '/weekly_jobs' , to: 'weekly_jobs#index', :as => 'weekly_jobs'

  get '/month_jobs' , to: 'month_jobs#index', :as => 'month_jobs'

  get 'each_month', to:'month_jobs#monthly' ,:as => 'each_month'

  get 'authorized', to: 'sessions#page_requires_login'

  get '/search' => 'search#search', :as => 'search_page'

  get '/search_jobs', to: 'search#index', :as => 'search_jobs'

  get '/search_range', to: 'search#search_range', :as => 'search_range'

  get '/search_range_results', to: 'search#search_range_results', :as => 'search_range_results'



  root 'sessions#welcome'

  delete 'logout'  => 'sessions#destroy'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
