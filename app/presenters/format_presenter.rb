class FormatPresenter < BasePresenter
  alias_method :format, :object

  def regions
    return 'None' if format.regions.empty?

    format.regions.map(&:name).join(', ')
  end
end
