class EditionsController < ApplicationController
  def index
    @dashboard = EditionsDashboard.new
  end

  def new
    edition = Edition.new
    @form = EditionForm.new(edition)
  end

  def create
    edition = Edition.new
    @form = EditionForm.new(edition)

    if @form.submit(edition_params)
      redirect_to edit_edition_path(edition), notice: 'Edition was successfully created.'
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

    if @form.submit(edition_params)
      redirect_to editions_path, notice: 'Edition was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    edition = find_edition
    edition.destroy

    redirect_to editions_path, notice: 'Edition was successfully destroyed.'
  end

  private

  def edition_params
    params.require(:edition).permit(:name, :distributor_id, :country_code, :release_date, format_params, packaging_params)
  end

  def format_params
    { formats_attributes: [:id, :format_id, :number_of_discs, :_destroy] }
  end

  def packaging_params
    { packagings_attributes: [:id, :packaging_id, :_destroy] }
  end

  def find_edition
    Edition.find(params[:id])
  end
end
