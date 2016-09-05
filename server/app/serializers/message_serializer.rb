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

class MessageSerializer < ActiveModel::Serializer
  attributes :id, :portfolio_id, :content, :created_at

  belongs_to :portfolio
end
