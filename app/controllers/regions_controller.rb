class RegionsController < ApplicationController
  def index
    @dashboard = RegionsDashboard.new
  end

  def new
    region = Region.new
    @form = RegionForm.new(region)
  end

  def create
    region = Region.new(region_params)
    @form = RegionForm.new(region)

    if @form.submit(params[:region])
      redirect_to regions_path, notice: 'Region was successfully created.'
    else
      render :new
    end
  end

  def edit
    region = find_region
    @form = RegionForm.new(region)
  end

  def update
    region = find_region
    @form = RegionForm.new(region)

    if @form.submit(params[:region])
      redirect_to regions_path, notice: 'Region was successfully updated.'
    else
      render :edit
    end
  end

  private

  def region_params
    params.require(:region).permit(:name, :format_id)
  end

  def find_region
    Region.find(params[:id])
  end
end
