# This should be refactored to be a has_and_belongs_to_many association
class ChoicesUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :choice
end
