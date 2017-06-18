class EditionDecorator < SimpleDelegator
  extend ActiveModel::Naming

  def to_model
    self
  end

  def country
    @country = ISO3166::Country[country_code]
    @country.translations[I18n.locale.to_s] || @country.name
  end
end
