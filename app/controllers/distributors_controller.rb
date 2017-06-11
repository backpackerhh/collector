class DistributorsController < ApplicationController
  def index
    @dashboard = DistributorsDashboard.new
  end

  def new
    distributor = Distributor.new
    @form = DistributorForm.new(distributor)
  end

  def create
    distributor = Distributor.new(distributor_params)
    @form = DistributorForm.new(distributor)

    if @form.submit(params[:distributor])
      redirect_to distributors_path, notice: 'Distributor was successfully created.'
    else
      render :new
    end
  end

  def edit
    distributor = find_distributor
    @form = DistributorForm.new(distributor)
  end

  def update
    distributor = find_distributor
    @form = DistributorForm.new(distributor)

    if @form.submit(params[:distributor])
      redirect_to distributors_path, notice: 'Distributor was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    distributor = find_distributor
    distributor.destroy

    redirect_to distributors_path, notice: 'Distributor was successfully destroyed.'
  end

  private

  def distributor_params
    params.require(:distributor).permit(:name)
  end

  def find_distributor
    Distributor.find(params[:id])
  end
end
