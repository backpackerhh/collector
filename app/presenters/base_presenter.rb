class BasePresenter
  attr_reader :object, :template

  def initialize(object, template)
    @object = object
    @template = template
  end

  def name
    link_to object.name, [:edit, object]
  end

  def destroy
    link_to 'Delete', object, method: :delete, data: { confirm: 'Are you sure?' }
  end

  private

  # Any method that object does not respond to, is delegated to the template, such as link_to or render
  def method_missing(*args, &block)
    template.public_send(*args, &block)
  end
end
