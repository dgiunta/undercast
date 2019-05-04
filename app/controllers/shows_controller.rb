class ShowsController < ApplicationController
  before_action :find_shows, only: [:index]
  before_action :find_show, only: [:show]
end
