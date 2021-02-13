class UploadFilesController < ApplicationController
  
  before_action :file_params, only: [:create]
  before_action :set_upload_file, only: [:show]
  
  def create
    if valid_file?
      file = UploadFile.new(name: file_params[:file].original_filename, path: file_params[:file].path)
      save_upload_file(file) if file.read_file
      return redirect_to upload_file_path(file) unless file.new_record?
    end
    redirect_to root_path, flash: { error: 'Não foi possivel carregar o arquivo.' } 
  end

  def show
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

  def set_upload_file
    total_parliamentary_expenditure =
      ParliamentaryExpenditure.joins(:parliamentarian)
                              .where(parliamentarians: { upload_file_id: params[:id] })
                              .group(:parliamentarian_id)
                              .sum(:vlrLiquido)
                              .to_h

    @parliamentarians = Parliamentarian.where(upload_file_id: params[:id]).map do |p|
      [p, total_parliamentary_expenditure[p.id]]
    end

    @parliamentarians = @parliamentarians.sort_by { |_key, value| -value }
  end

  def save_upload_file(file)
    UploadFile.transaction do
      raise ActiveRecord::Rollback unless file.save

      parliamentarian_id_list = file.rows.map { |row| row[:ideCadastro] }.uniq

      parliamentarian_id_list.each do |ide_cadastro|
        parliamentarian_rows = file.rows.select { |row| row[:ideCadastro] == ide_cadastro }

        parliamentarian_attrs = parliamentarian_rows.first.slice(:txNomeParlamentar, :cpf, :ideCadastro, :sgPartido)
        parliamentarian = file.parliamentarians.create(**parliamentarian_attrs)

        parliamentary_expenditure_attrs = parliamentarian_rows.map do |row|
          hash = row.slice(:datEmissao, :txtFornecedor, :vlrLiquido, :ideDocumento, :urlDocumento)
          hash.merge!({ parliamentarian_id: parliamentarian.id, created_at: Time.now.utc, updated_at: Time.now.utc})
        end
        parliamentarian.parliamentary_expenditures.insert_all!(parliamentary_expenditure_attrs)
        raise ActiveRecord::Rollback if parliamentarian.parliamentary_expenditures.count != parliamentary_expenditure_attrs.count
      end
      raise ActiveRecord::Rollback if file.parliamentarians.count != parliamentarian_id_list.count
    end
  end
end
