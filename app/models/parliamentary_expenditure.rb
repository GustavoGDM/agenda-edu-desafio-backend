# Table name: parliamentarians
#
# id:                     integer
# datEmissao              date
# txtFornecedor           string
# vlrLiquido              float
# parliamentarian_id      integer
# created_at              datetime
# updated_at              datetime

class ParliamentaryExpenditure < ApplicationRecord
  belongs_to :parliamentarian
  validates_presence_of :datEmissao, :txtFornecedor, :vlrLiquido, :parliamentarian_id
end
