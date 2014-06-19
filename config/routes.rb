TvShows::Application.routes.draw do
  resources :television_shows, only: [:index, :show, :new, :create] do
    resources :characters, only: [ :create, :destroy]
  end

  resources :characters, only: [:index]

  get '/', to: 'television_shows#index'
end
