class ParliamentariansController < ApplicationController
  before_action :set_parliamentarian
  before_action :set_parliamentary_expenditures
  before_action :set_monthly_parliamentary_expenditures
 
  def show
  end

  private

  def set_parliamentarian
    @parliamentarian = Parliamentarian.find(params[:id])
  end

  def set_parliamentary_expenditures
    @parliamentary_expenditures =
      ParliamentaryExpenditure.joins(:parliamentarian)
                              .where(parliamentarians: { id: params[:id] })
                              .order(vlrLiquido: :desc)
  end

  def set_monthly_parliamentary_expenditures
    @monthly_parliamentary_expenditures =
      @parliamentary_expenditures.where.not(datEmissao: nil)
                                 .group_by { |pe| pe.datEmissao.month }
                                 .map { |monyh, group| [monyh, '%.2f' % group.inject(0) { |sum, n| sum + n.vlrLiquido }] }
                                 .sort_by!{|month, _value| month }
  end
end
