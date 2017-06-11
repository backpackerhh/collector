class FormatsController < ApplicationController
  def index
    @dashboard = FormatsDashboard.new
  end
end
