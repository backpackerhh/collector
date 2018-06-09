class EditionPresenter < BasePresenter
  alias_method :edition, :object

  def country
    @country = ISO3166::Country[edition.country_code]
    @country.translations[I18n.locale.to_s] || @country.name
  end

  def formats
    return 'Not specified' if edition.formats.empty?

    edition.formats.map { |format| [format.number_of_discs, format.name].join(' ') }.join(', ')
  end

  def packagings
    return 'Not specified' if edition.packagings.empty?

    edition.packagings.map(&:name).join(', ')
  end
end
