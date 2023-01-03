class User < ApplicationRecord
  has_secure_password
  def self.authenticate_with_credentials(email, password)
    @user = User.find_by email: email.downcase.strip
    unless @user 
      return nil
    end  
    if @user.authenticate(password)
      return @user
    else  
      return nil
    end  
  end  
	# Verify that email field is not blank and that it doesn't already exist in the db (prevents duplicates):
	validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :password, length: { minimum: 8 }
end
