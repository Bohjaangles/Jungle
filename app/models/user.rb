class User < ApplicationRecord
  has_secure_password

	# Verify that email field is not blank and that it doesn't already exist in the db (prevents duplicates):
	validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :last_name, presence: true
  validates :first_name, presence: true

end
