Rails.application.routes.draw do

  resources :users
  resources :anime_entries

  get '/' => 'application#index'
  get '/:uid' => 'user#show'
  get '/secret/admin/page' => 'admin#index'
  post '/secret/admin/page/anime' => 'admin#importAnime'
  post '/secret/admin/page/clearAnimeDB' => 'admin#clearAnimeDB'
  post '/secret/admin/page/clearUserDB' => 'admin#clearUserDB'
  post '/secret/admin/page/clearEntryDB' => 'admin#clearEntryDB'
  post '/secret/admin/page/importGenres' => 'admin#importGenres'

end
