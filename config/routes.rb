PartyTime::Application.routes.draw do
  root to: "playlists#new"
  resources :recommender, only: [:create]
  resources :playlists do
    resource :tracks
  end
end
