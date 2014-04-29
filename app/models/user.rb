class User < ActiveRecord::Base
	before_validation if: :password



	def self.create_default_user(password)
		self.create!(firstname: default, lastname: user, login: "malou&manu", password: password)
	end

	def cypher_password
		self[:salt] ||= BCrypt::Engine.generate_salt
		self[:encrypted_password] ||= BCrypt::Engine.hash_secret(@password, self[:salt])
	end

	def check_password(password)
		BCrypt::Engine.hash_secret(password, self[:salt]) == self[:encrypted_password]
	end
end
