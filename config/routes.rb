PartyTime::Application.routes.draw do
  root to: "playlists#new"
  resources :playlists do
    resource :tracks
  end
end
