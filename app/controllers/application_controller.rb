class ApplicationController < ActionController::Base
  def shows
    @shows = Show.all
  end

  def show
    @show = Show.find_by_id(params[:show])
  end

  def episodes
    @show = Show.find_by_id(params[:show])
  end

  def play
    @show = Show.find_by_id(params[:show])
    @next_track = @show.find_episode_by_id(params[:title])
    respond_to do |format|
      format.html { render :home }
      format.js
    end
  end
end
