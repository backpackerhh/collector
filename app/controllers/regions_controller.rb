class RegionsController < ApplicationController
  def index
    @dashboard = RegionsDashboard.new
  end
end
