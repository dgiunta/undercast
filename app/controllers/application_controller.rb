class ApplicationController < ActionController::Base
  before_action :find_shows, only: :shows
  before_action :find_show, only: [:show, :episodes, :episode, :play]
  before_action :find_episode, only: [:episode, :play]

  def play
    respond_to do |format|
      format.html { redirect_to episode_path(show_id: @episode.show, id: @episode) }
      format.js
    end
  end

  private

  def find_shows
    @shows = Show.all
  end

  def find_show
    @show = Show.find_by_id(params[:show_id] || params[:id])
  end

  def find_episode
    @episode = @show.find_episode_by_id(params[:episode_id] || params[:id])
  end
end
