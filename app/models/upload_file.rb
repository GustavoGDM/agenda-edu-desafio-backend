# Table name: upload_files
#
# id:                   integer
# name:                 string

require 'csv'
class UploadFile < ApplicationRecord

  has_many :parliamentarians
  attr_accessor :path
  attr_reader :rows

  validates :name, presence: true

  def read_file
    @rows = []
    CSV.foreach(@path, liberal_parsing: true, col_sep: ';', headers: true) do |row|
      if row['sgUF'] == 'RJ'
        @rows << row.to_h.transform_keys do |key|
          key = key.gsub(/[^0-9A-Za-z]/, '') if key.include?("\"")
          key.to_sym
        end
      end
    end
    @rows.any?
  end

end
