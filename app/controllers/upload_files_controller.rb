class UploadFilesController < ApplicationController
  require 'csv'
  before_action :file_params

  def create
    return unless valid_file?

    file = UploadFile.new(name: file_params[:file].original_filename )
    rows = CSV.read(file_params[:file].path, liberal_parsing: true, col_sep: ';', headers: true).select do |row|
      row['sgUF'] == 'RJ'
    end

    if rows.any?
      UploadFile.transaction do
        file.save
        parliamentarian_id_list = rows.map{ |row| row['ideCadastro'] }.uniq

        parliamentarian_id_list.each do |ide_cadastro|
          parliamentarian_rows = rows.select { |row| row['ideCadastro'] == ide_cadastro }

          parliamentarian_rows_hash = parliamentarian_rows.map do |row|
            row.to_h.transform_keys do |key|
              key.gsub(/[^0-9A-Za-z]/, '').to_sym
            end
          end

          parliamentarian_attrs = parliamentarian_rows_hash.first.slice(:txNomeParlamentar, :cpf, :ideCadastro, :sgPartido)
          parliamentarian = Parliamentarian.where(**parliamentarian_attrs).first
          parliamentarian = file.parliamentarians.create(**parliamentarian_attrs) if parliamentarian.blank?

          parliamentarian_rows_hash.each do |rows_hash|
            parliamentary_expenditure_attrs = rows_hash.slice(:datEmissao, :txtFornecedor, :vlrLiquido, :ideDocumento, :urlDocumento)
            parliamentarian.parliamentary_expenditures.create(**parliamentary_expenditure_attrs)
          end
        end
        raise ActiveRecord::Rollback if file.parliamentarians.blank? && file.parliamentarians.map(&:parliamentary_expenditures).count != rows.count
      end
      head :ok unless file.new_record?
    end
  end

  private

  def file_params
    params.permit(:file, :authenticity_token, :commit)
  end

  def valid_file?
    file_params[:file].present? &&
      file_params[:file].tempfile.present? &&
      file_params[:file].tempfile.path['.csv'].length == 4
  end
end
