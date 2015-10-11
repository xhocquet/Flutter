Rails.application.routes.draw do

  resources :users
  resources :anime_entries

  get '/' => 'application#index'
  get '/user/general/:username' => 'user#general'
  get '/user/library/:username' => 'user#library'
  get '/user/history/:username' => 'user#history'
  get '/user/trends/:username' => 'user#trends'
  get '/user/ratings/:username' => 'user#ratings'
  get '/user/refreshData/:username' => 'user#refreshData'
  get '/secret/admin/page' => 'admin#index'
  post '/secret/admin/page/anime' => 'admin#importAnime'
  post '/secret/admin/page/clearAnimeDB' => 'admin#clearAnimeDB'
  post '/secret/admin/page/clearUserDB' => 'admin#clearUserDB'
  post '/secret/admin/page/clearEntryDB' => 'admin#clearEntryDB'
  post '/secret/admin/page/importGenres' => 'admin#importGenres'

end
