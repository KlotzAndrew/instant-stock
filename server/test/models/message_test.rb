# == Schema Information
#
# Table name: messages
#
#  id           :uuid             not null, primary key
#  portfolio_id :uuid             not null
#  content      :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'test_helper'

class MessageTest < ActiveSupport::TestCase
  context '#relations' do
    should belong_to :portfolio
  end

  context '#validations' do
    should validate_presence_of :portfolio_id
  end
end
