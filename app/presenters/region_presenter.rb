class RegionPresenter < BasePresenter
  alias_method :region, :object

  def format
    region.format_name
  end
end
