class User < ActiveRecord::Base
  
  has_secure_password
  
  has_secure_password validations: true
  validates :name, presence: true, uniqueness: true
  
  def self.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def self.encrypt(token)
    Digest::SHA256.hexdigest(token.to_s)
  end
  
end