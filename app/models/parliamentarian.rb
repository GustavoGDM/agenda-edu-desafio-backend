# Table name: parliamentarians
#
# id:                   integer
# name:                 string
# cpf:                  string
# ideCadastro:          integer
# sgPartido:            string
# upload_file_id:       integer
# created_at:           datetime
# updated_at:           datetime

class Parliamentarian < ApplicationRecord
  belongs_to :upload_file
  has_many :parliamentary_expenditures

  validates_presence_of :name, :cpf, :ideCadastro, :sgPartido
end
