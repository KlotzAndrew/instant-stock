require 'test_helper'

class MinuteBarsControllerTest < ActionDispatch::IntegrationTest
  setup do
  end

  test 'should get index' do
    skip 'tbd'
    get minute_bars_url, as: :json
    assert_response :success
  end

  test 'should create minute_bar' do
    skip 'tbd'
    assert_difference('MinuteBar.count') do
      post minute_bars_url, params: { minute_bar: {} }, as: :json
    end

    assert_response 201
  end

  test 'should show minute_bar' do
    skip 'tbd'
    get minute_bar_url(@minute_bar), as: :json
    assert_response :success
  end

  test 'should update minute_bar' do
    skip 'tbd'
    patch minute_bar_url(@minute_bar), params: { minute_bar: {} }, as: :json
    assert_response 200
  end

  test 'should destroy minute_bar' do
    skip 'tbd'
    assert_difference('MinuteBar.count', -1) do
      delete minute_bar_url(@minute_bar), as: :json
    end

    assert_response 204
  end
end
