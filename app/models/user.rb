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
	before_validation :set_login
	before_save :set_response, :save_partner

	validates_uniqueness_of :login
	validates_presence_of :login

	def password=(password); @password = password; end
	def password; @password; end

	def name; "#{self[:firstname]} #{self[:lastname]}"; end

	def wedding=(value); response[:wedding] = value; end
	def cocktail=(value); response[:cocktail] = value; end
	def dinner=(value); response[:dinner] = value; end
	def party=(value); response[:party] = value; end
	def wedding; response[:wedding]; end
	def cocktail; response[:cocktail]; end
	def dinner; response[:dinner]; end
	def party; response[:party]; end
	def set_response; self.presence = self.response.to_yaml; end
	def response; @response ||= (self.presence ? YAML.load(presence) : {}); end

	def partner; @partner ||= User.find_by(id: partner_id) || self.persisted? && User.find_by(partner_id: self[:id]) || User.new; end
	def partner=(partner); @partner = partner; end
	def save_partner
		if @partner.present?
			partner = self.class.where(login: self.class.login(@partner)).first_or_create!
			partner.update_attributes(@partner)
			self[:partner_id] = partner[:id]
		end
		true
	end

	def set_login;	self[:login] ||= User.login(self);	end
	def self.login(user_hash); "#{user_hash[:firstname]}#{user_hash[:lastname]}".without_accent.gsub(/\s+/, "");		end

	def self.create_default_user(password)
		create!(firstname: "default", lastname: "user", login: "default user", password: password)
	end
	def self.default_user
    	find_by!(firstname: "default", lastname: "user", login: "default user")
	end
	  
	def self.name_without_accent(hash)
		{firstname: hash[:firstname], lastname: hash[:lastname].without_accent}
	end

	def cypher_password
		self[:salt] ||= BCrypt::Engine.generate_salt
		self[:encrypted_password] ||= BCrypt::Engine.hash_secret(@password, self[:salt])
	end

	def self.check_password(password)
		BCrypt::Engine.hash_secret(password, default_user[:salt]) == default_user[:encrypted_password]
	end
end
