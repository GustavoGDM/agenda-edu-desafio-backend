class ParliamentariansController < ApplicationController
  before_action :set_parliamentarian
  before_action :set_parliamentary_expenditures
  before_action :set_monthly_parliamentary_expenditures
  before_action :set_total_parliamentary_expenditures
  before_action :set_average_parliamentary_expenditures
  before_action :set_ranking_parliamentary_expenditures

  def show 
  end

  private

  def set_parliamentarian
    @parliamentarian = Parliamentarian.find(params[:id])
  end

  def set_parliamentary_expenditures
    @parliamentary_expenditures = @parliamentarian.parliamentary_expenditures.order(vlrLiquido: :desc)
  end

  def set_total_parliamentary_expenditures
    @total_parliamentary_expenditures = '%.2f' % @parliamentary_expenditures.sum(:vlrLiquido)
  end

  def set_average_parliamentary_expenditures
    @average_parliamentary_expenditures = '%.2f' % @parliamentary_expenditures.average((:vlrLiquido))
  end

  def set_monthly_parliamentary_expenditures
    @monthly_parliamentary_expenditures =
      @parliamentary_expenditures.where.not(datEmissao: nil)
                                 .group_by { |pe| pe.datEmissao.month }
                                 .map { |monyh, group| [monyh, '%.2f' % group.inject(0) { |sum, n| sum + n.vlrLiquido }] }
                                 .sort_by!{ |month, _value| month }
  end

  def set_ranking_parliamentary_expenditures
    total_parliamentary_expenditure = 
      ParliamentaryExpenditure.joins(:parliamentarian)
                              .where(parliamentarians: { upload_file_id: @parliamentarian.upload_file_id })
                              .group(:parliamentarian_id)
                              .sum(:vlrLiquido)
                              .sort_by { |_key, value| -value }

    @ranking_parliamentary_expenditures =
      total_parliamentary_expenditure.find_index { |id, _value| id == @parliamentarian.id } + 1
  end

end
