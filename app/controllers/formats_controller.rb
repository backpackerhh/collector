class FormatsController < ApplicationController
  def index
    @dashboard = FormatsDashboard.new
  end

  def new
    format = Format.new
    @form = FormatForm.new(format)
  end

  def create
    format = Format.new
    @form = FormatForm.new(format)

    if @form.submit(format_params)
      redirect_to formats_path, notice: 'Format was successfully created.'
    else
      render :new
    end
  end

  def edit
    format = find_format
    @form = FormatForm.new(format)
  end

  def update
    format = find_format
    @form = FormatForm.new(format)

    if @form.submit(format_params)
      redirect_to formats_path, notice: 'Format was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    format = find_format
    format.destroy

    redirect_to formats_path, notice: 'Format was successfully destroyed.'
  end

  private

  def format_params
    params.require(:format).permit(:name)
  end

  def find_format
    Format.find(params[:id])
  end
end
