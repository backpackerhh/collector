module PresenterHelpers
  def mock_action_view
    ActionView::Base.send(:include, Rails.application.routes.url_helpers)
    ActionView::Base.new(ActionController::Base.view_paths, {})
  end
end
