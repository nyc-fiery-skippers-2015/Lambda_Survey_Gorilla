class Survey < ActiveRecord::Base
  has_many :taken_surveys
  has_many :users, through: :taken_surveys
  has_one :creator, class_name: 'User'
  has_many :questions
end
