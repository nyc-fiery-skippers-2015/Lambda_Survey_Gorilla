class Choice < ActiveRecord::Base
  belongs_to :question
  has_many :choices_users
  has_many :users, through: :choices_users
end
