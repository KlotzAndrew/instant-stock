require 'test_helper'

class UpdateStocksMinuteBarsTest < ActiveSupport::TestCase
  test 'calls correct interactors' do
    assert UpdateStocksMinuteBars.organized.include? FetchMinuteBars
    assert UpdateStocksMinuteBars.organized.include? CreateMinuteBars
  end
end
