class DistributorsController < ApplicationController
  def index
    @dashboard = DistributorsDashboard.new
  end
end
