class User < ActiveRecord::Base


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
