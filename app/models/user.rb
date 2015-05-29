class User < ActiveRecord::Base
  include BCrypt

  has_many :created_surveys, class_name: 'Survey', foreign_key: 'creator_id'
  has_many :taken_surveys
  has_many :surveys, through: :taken_surveys
  has_many :choices_users
  has_many :choices, through: :choices_users

  def authenticate(plaintext_password)
    self.password == plaintext_password
  end

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end
end
