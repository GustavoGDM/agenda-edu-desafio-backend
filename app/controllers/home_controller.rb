class HomeController < ApplicationController
  before_action :set_latest_files
  def index
  end
  private

  def set_latest_files
    @files = UploadFile.limit(5).order(created_at: :desc)
  end
end
