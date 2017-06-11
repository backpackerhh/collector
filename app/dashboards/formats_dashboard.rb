# Use a facade pattern to provide a simplified interface to a larger body of code present in the controller
#
# The views are fed only with an instance of this class, using its public methods
class FormatsDashboard
  def formats
    Format.order(:name)
  end
end
