class EmailOpt < ApplicationRecord
  validates :email, :valid_until, :activated, presence: true
end
