class EpisodesController < ApplicationController
  before_action :find_show
  before_action :find_episode, only: [:show, :play]

  def play
    respond_to do |format|
      format.html do
        redirect_to show_episode_path(
          show_id: @episode.show.id,
          id: @episode.id
        )
      end
      format.js
    end
  end
end
