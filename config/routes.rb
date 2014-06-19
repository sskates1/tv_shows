TvShows::Application.routes.draw do
  resources :television_shows, only: [:index, :show, :new, :create] do
    resources :characters, only: [:index, :create, :destroy]
  end

  get '/', to: 'television_shows#index'
end
