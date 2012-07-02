PartyTime::Application.routes.draw do
  root to: "playlists#new"
  resource :search, only: [ :create ]
  resource :deal, only: [ :show ]
  resources :playlists do
    resource :tracks
  end
end
