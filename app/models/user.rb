# coding: utf-8
# 
# == Schema Information
#
# Table name: users
#
#  id                 :integer          not null, primary key
#  firstname          :string(255)
#  lastname           :string(255)
#  email              :string(255)
#  login              :string(255)
#  salt               :string(255)
#  encrypted_password :string(255)
#  partner_id         :integer
#  street             :string(255)
#  address_add        :string(255)
#  town               :string(255)
#  zip_code           :string(255)
#  message_address    :text
#  created_at         :datetime
#  updated_at         :datetime
#  presence           :string(255)
#  message_response   :string(255)
#  phone              :string(255)
#

require 'bcrypt'
require 'yaml'

class String
  def without_accent
    gsub(/[ÀÁÂÃÄáàâäã]/, "a")
    gsub(/[Çç]/, "c")
    gsub(/[ÈÉÊËẼéèêëẽ]/, "e")
    gsub(/[ÌÍÎÏĨîïíĩì]/, "i")
    gsub(/[ÒÓÔÕÖôöóòõ]/, "i")
    gsub(/[ÙÚÛÜŨùúûüũ]/, "i")
    titleize
  end
end

class User < ActiveRecord::Base
	before_validation :cypher_password, if: :password
	before_save :set_response

	def password=(password); @password = password; end
	def password; @password; end

	def wedding=(value); response[:wedding] = value; end
	def cocktail=(value); response[:cocktail] = value; end
	def dinner=(value); response[:dinner] = value; end
	def party=(value); response[:party] = value; end
	def wedding; response[:wedding]; end
	def cocktail; response[:cocktail]; end
	def dinner; response[:dinner]; end
	def party; response[:party]; end
	def set_response; puts "before_save"; self.presence = self.response.to_yaml; end
	def response; @response ||= (self.presence ? YAML.load(presence) : {}); end

	def self.create_default_user(password)
		create!(firstname: "default", lastname: "user", login: "mariage", password: password)
	end
  def self.default_user
    find_by!(firstname: "default", lastname: "user", login: "mariage")
  end
  
  def self.name_without_accent(hash)
    {firstname: hash[:firstname].without_accent, lastname: hash[:lastname].without_accent}
  end

	def cypher_password
		self[:salt] ||= BCrypt::Engine.generate_salt
		self[:encrypted_password] ||= BCrypt::Engine.hash_secret(@password, self[:salt])
	end

	def self.check_password(password)
		BCrypt::Engine.hash_secret(password, default_user[:salt]) == default_user[:encrypted_password]
	end
end
