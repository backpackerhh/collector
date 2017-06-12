class PackagingsController < ApplicationController
  def index
    @dashboard = PackagingsDashboard.new
  end

  def new
    packaging = Packaging.new
    @form = PackagingForm.new(packaging)
  end

  def create
    packaging = Packaging.new(packaging_params)
    @form = PackagingForm.new(packaging)

    if @form.submit(params[:packaging])
      redirect_to packagings_path, notice: 'Packaging was successfully created.'
    else
      render :new
    end
  end

  def edit
    packaging = find_packaging
    @form = PackagingForm.new(packaging)
  end

  def update
    packaging = find_packaging
    @form = PackagingForm.new(packaging)

    if @form.submit(params[:packaging])
      redirect_to packagings_path, notice: 'Packaging was successfully updated.'
    else
      render :edit
    end
  end

  private

  def packaging_params
    params.require(:packaging).permit(:name)
  end

  def find_packaging
    Packaging.find(params[:id])
  end
end
