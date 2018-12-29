class User < ActiveRecord::Base
  
  has_secure_password
  
  has_secure_password validations: true
  validates :name, presence: true, uniqueness: true
  
  def self.new_remember_token
    logger.debug("User.new_remember_token called!")
    SecureRandom.urlsafe_base64
  end

  def self.encrypt(token)
    logger.debug("User.encrypt called!")
    Digest::SHA256.hexdigest(token.to_s)
  end
  
end