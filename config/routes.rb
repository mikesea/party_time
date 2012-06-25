PartyTime::Application.routes.draw do
  root to: "main#index"
  resources :playlists do
    resource :tracks
  end
end
