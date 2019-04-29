Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "/shows/:show" => "application#show", as: :show
  get "/shows" => "application#shows", as: :shows
  get "/shows/:show/episodes" => "application#episodes", as: :show_episodes
  get "/shows/:show/episodes/:title/play" => "application#play", as: :play_show_episode

  root to: "application#shows"
end
