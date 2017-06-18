class EditionsController < ApplicationController
  def index
    @dashboard = EditionsDashboard.new
  end
end
