class User < ActiveRecord::Base
  has_many :created_surveys, class_name: 'Survey' foreign_key: 'creator_id'
  has_many :taken_surveys
  has_many :surveys, through: :taken_surveys
  has_many :choices_users
  has_many :choices, through: :choices_users
end
