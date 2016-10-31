require 'test_helper'

class DayBarsControllerTest < ActionDispatch::IntegrationTest
  setup do
  end

  test 'should get index' do
    skip 'tbd'
    get day_bars_url, as: :json
    assert_response :success
  end

  test 'should create day_bar' do
    skip 'tbd'
    assert_difference('DayBar.count') do
      post day_bars_url, params: { day_bar: {} }, as: :json
    end

    assert_response 201
  end

  test 'should show day_bar' do
    skip 'tbd'
    get day_bar_url(@day_bar), as: :json
    assert_response :success
  end

  test 'should update day_bar' do
    skip 'tbd'
    patch day_bar_url(@day_bar), params: { day_bar: {} }, as: :json
    assert_response 200
  end

  test 'should destroy day_bar' do
    skip 'tbd'
    assert_difference('DayBar.count', -1) do
      delete day_bar_url(@day_bar), as: :json
    end

    assert_response 204
  end
end
