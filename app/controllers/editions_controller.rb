class EditionsController < ApplicationController
  def index
    @dashboard = EditionsDashboard.new
  end

  def new
    edition = Edition.new
    @form = EditionForm.new(edition)
  end

  def create
    edition = Edition.new(edition_params)
    @form = EditionForm.new(edition)

    if @form.submit(params[:edition])
      redirect_to editions_path, notice: 'Edition was successfully created.'
    else
      render :new
    end
  end

  def edit
    edition = find_edition
    @form = EditionForm.new(edition)
  end

  def update
    edition = find_edition
    @form = EditionForm.new(edition)

    if @form.submit(params[:edition])
      redirect_to editions_path, notice: 'Edition was successfully updated.'
    else
      render :edit
    end
  end

  private

  def edition_params
    params.require(:edition).permit(:name, :distributor_id, :country_code, :release_date)
  end

  def find_edition
    Edition.find(params[:id])
  end
end
