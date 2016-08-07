# == Schema Information
#
# Table name: minute_bars
#
#  id             :uuid             not null, primary key
#  stock_id       :uuid             not null
#  data_source    :string           not null
#  quote_time     :datetime         not null
#  high           :decimal(15, 2)
#  open           :decimal(15, 2)
#  close          :decimal(15, 2)
#  adjusted_close :decimal(15, 2)
#  volume         :decimal(15, 2)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

require 'test_helper'

class MinuteBarTest < ActiveSupport::TestCase
  context '#relations' do
    should belong_to :stock
  end
end
