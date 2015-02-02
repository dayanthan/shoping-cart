class User < ActiveRecord::Base
	validates_presence_of :user_name,:password, :password_confirmation, :user_email
	# validates :user_email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
	has_one :profile , dependent: :destroy
	has_many :categories
	attr_accessor :password_confirmation, :new_password
	before_create :generate_access_token

	private
  
  def generate_access_token
    begin
      self.access_token = SecureRandom.hex
    end while self.class.exists?(access_token: access_token)
  end
end


