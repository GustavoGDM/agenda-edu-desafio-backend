# Table name: upload_files
#
# id:                   integer
# name:                 string
# created_at              datetime
# updated_at              datetime

require 'csv'
class UploadFile < ApplicationRecord

  has_many :parliamentarians
  attr_accessor :file, :rows, :path

  validates :name, presence: true

  after_initialize do
    self.path = file.path if file.present?
  end

  def read_file
    self.rows = []
    begin
      CSV.foreach(path, liberal_parsing: true, col_sep: ';', headers: true) do |row|
        if row['sgUF'] == 'RJ'
          rows << row.to_h.transform_keys do |key|
            key = key.gsub(/[^0-9A-Za-z]/, '') if key.include?("\"")
            key.to_sym
          end
        end
      end
    rescue e
      return false
    end
    rows.any?
  end

  def is_valid?
    file.present? && path['.csv'].length == 4
  end

end
