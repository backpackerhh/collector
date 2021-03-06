class PackagingsController < ApplicationController
  def index
    @dashboard = PackagingsDashboard.new
  end

  def new
    packaging = Packaging.new
    @form = PackagingForm.new(packaging)
  end

  def create
    packaging = Packaging.new
    @form = PackagingForm.new(packaging)

    if @form.submit(packaging_params)
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

    if @form.submit(packaging_params)
      redirect_to packagings_path, notice: 'Packaging was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    packaging = find_packaging
    packaging.destroy

    redirect_to packagings_path, notice: 'Packaging was successfully destroyed.'
  end

  private

  def packaging_params
    params.require(:packaging).permit(:name)
  end

  def find_packaging
    Packaging.find(params[:id])
  end
end
