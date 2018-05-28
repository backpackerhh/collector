class BasePresenter
  attr_reader :object, :template

  def initialize(object, template)
    @object = object
    @template = template
  end

  private

  # Any method that object does not respond to, is delegated to the template, such as link_to or render
  def method_missing(*args, &block)
    template.public_send(*args, &block)
  end
end
