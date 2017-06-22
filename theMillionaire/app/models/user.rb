class User < ActiveRecord::Base

  validates :user_id, :presence => true, :uniqueness => true
  validates :name, :presence => true, :uniqueness => true
  validates :password, :presence => true, :uniqueness => true



before_create :digest_password
   def self.authenticate(user_id, password)
       where(:user_id => user_id, :password =>
Digest::SHA1.hexdigest(password)).first
   end
   private
   def digest_password
        self.password = Digest::SHA1.hexdigest(self.password)
   end

end
