class PackagingsController < ApplicationController
  def index
    @dashboard = PackagingsDashboard.new
  end
end
