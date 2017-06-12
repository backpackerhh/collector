# Use a form object to simplify models and controllers. When necessary, this approach allow us to encapsulate
# the aggregation of multiple ActiveRecord models, eliminating the need for "accepts_nested_attributes_for" method.
#
# There are many form object implementations, such as Reform and Virtus, but require some duplication of logic for
# what we need. They usually require the validation logic to be present in the form object, even if they are already
# present in the model.
#
# With this solution the validation logic remains in the original models where it should be. Additional validations
# can be added to the form object itself to verify the validity of the objects as a group.
class PackagingForm
  # This module includes model name introspections, conversions, translations and validations.
  # Besides that, it allows us to initialize the object with a hash of attributes.
  include ActiveModel::Model

  attr_reader :packaging

  # Returns the attributes of the model, including the name of its associations
  #
  # @return [Array] attributes of the model and name of its associations
  def self.packaging_attributes
    Packaging.column_names + Packaging.reflections.keys
  end

  # Used to retrieve all kinds of naming-related information
  #
  # @see {ActiveModel::Name}
  def self.model_name
    ActiveModel::Name.new(self, nil, 'Packaging')
  end

  # Delegates getter and setter methods for each of the attributes back to the original model
  packaging_attributes.each do |attr|
    delegate attr, "#{attr}=", to: :packaging
  end

  def initialize(packaging)
    @packaging = packaging
  end

  # Sends the form with values filled by user
  #
  # When the form and the packaging are both valid, the record is saved. Otherwise, the form displays all errors
  # found in validation process.
  #
  # @param [Hash] params - form's attributes and its values
  #
  # @return [Boolean] true when packaging is saved, false otherwise
  def submit(params)
    preload_fields_with(params)

    if completely_valid?
      packaging.save!
      true
    else
      promote_errors(packaging.errors)
      false
    end
  end

  private

  # Loads form's attributes with values from given params before perform the validation
  #
  # Those fields that user filled, remain filled in case that any validation error is found.
  def preload_fields_with(params)
    %i(name).each do |field|
      self.public_send("#{field}=", params[field]) if params.has_key?(field)
    end
  end

  # Performs the validation of both, the form itself and the packaging
  #
  # In the case of the form, validates those fields that are exclusive to it.
  #
  # @note An auxiliary variable is necessary to perform both validations and check both results. If the variable
  # is replaced with a direct validation check, the code does not work because the second validation won't be
  # performed if the result of the first one is false.
  #
  # @return [Boolean] true when form and packaging are valid, false otherwise
  def completely_valid?
    packaging_valid = packaging.valid?
    valid? && packaging_valid
  end

  # Takes all given validation errors found in packaging and adds them to errors of the form itself. These errors
  # correspond with delegated attributes on the form object, that will be rendered as form fields in the view.
  # Since the attributes match, Simple Form will be able to handle the display of errors in the form the way
  # it normally would.
  #
  # @param [ActiveModel::Errors] child_errors - validation errors found in packaging
  def promote_errors(child_errors)
    child_errors.each do |attribute, message|
      errors.add(attribute, message)
    end
  end
end
