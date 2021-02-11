class UploadFileController < ApplicationController
  require 'csv'
  before_action :file_params

  def create
    if valid_file?
      file_params[:file].original_filename
      CSV.foreach(file_params[:file].path, liberal_parsing: true, row_sep: :auto, col_sep: ';', headers: true) do |row|
      end
    end
  end

  private

  def file_params
    params.permit(:file, :authenticity_token, :commit)
  end

  def valid_file?
    file_params[:file].present? && file_params[:file].tempfile.present? && file_params[:file].tempfile.path['.csv']
  end
end
