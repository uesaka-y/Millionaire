class User < ActiveRecord::Base

  validates :user_id, :presence => true, :uniqueness => true
validates :name, :presence => true, :uniqueness => true
validates :password, :presence => true, :uniqueness => true

  before_create :digest_password

  def self.authenticate(name,password)
    where(:name=>name, :password=>Digest::SHA1.hexdigest(password)).first
  end

  private
  def digest_password
    self.password=Digest::SHA1.hexdigest(self.password)
  end
end
