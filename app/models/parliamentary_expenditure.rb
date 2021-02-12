# Table name: parliamentarians
#
# id:                     integer
# datEmissao              date
# txtFornecedor           string
# vlrLiquido              float
# parliamentarian_id      integer
# ideDocumento            integer
# urlDocumento            string
# created_at              datetime
# updated_at              datetime

class ParliamentaryExpenditure < ApplicationRecord
  belongs_to :parliamentarian

  validates_presence_of :datEmissao, :txtFornecedor, :vlrLiquido, :parliamentarian_id, :ideDocumento, :urlDocumento
end
