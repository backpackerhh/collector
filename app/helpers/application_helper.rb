module ApplicationHelper
  # Allows to use a presenter from the views
  #
  # When no presenter class is provided, then the default one is inferred from object's class name
  #
  # @param [ActiveRecord] model - object to use in the presenter
  # @param [Class] presenter - class to use as presenter instead of the default one inferred from object's class
  def present(model, presenter: nil)
    presenter ||= "#{model.class}Presenter".constantize
    presenter_instance = presenter.new(model, self)

    yield(presenter_instance) if block_given?
  end
end
