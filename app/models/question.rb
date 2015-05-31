class Question < ActiveRecord::Base
  has_many :choices, dependent: :destroy
  belongs_to :survey
end
