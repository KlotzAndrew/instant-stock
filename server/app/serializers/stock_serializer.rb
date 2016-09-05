# == Schema Information
#
# Table name: stocks
#
#  id              :uuid             not null, primary key
#  ticker          :string           not null
#  stock_exchange  :string           not null
#  name            :string
#  currency        :string           not null
#  last_quote_time :datetime
#  last_quote      :decimal(15, 2)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class StockSerializer < ActiveModel::Serializer
  attributes :id, :ticker, :stock_exchange, :name, :currency

  has_many :stock_holdings
  has_many :portfolios, through: :stock_holdings
  has_many :day_bars
  has_many :minute_bars
end
