# == Schema Information
#
# Table name: holdings
#
#  id           :uuid             not null, primary key
#  active       :boolean          default(TRUE), not null
#  portfolio_id :uuid             not null
#  stock_id     :uuid             not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Holding < ApplicationRecord
  belongs_to :portfolio
  belongs_to :stock
  has_many :trades

  def current_total
    trades.to_a.sum(&:quantity)
  end
end
