PartyTime::Application.routes.draw do
  root to: "playlists#new"
  resource :search, only: [ :create ]
  resources :playlists do
    resource :tracks
  end
end
