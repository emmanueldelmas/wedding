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
require 'csv'

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
  def response?; response.present?; end
  def comes?; presence =~ /1/; end

	def partner; @partner ||= User.find_by(id: partner_id) || self.persisted? && User.find_by(partner_id: self[:id]) || User.new; end
	def partner=(partner); @partner = partner; end
	def save_partner
		if partner[:firstname].present?
			partner = self.class.where(login: self.class.login( partner)).first_or_create!
			partner.save!
			self[:partner_id] = partner[:id]
		end
		true
	end

	def set_login;	self[:login] ||= User.login(self);	end
	def self.login(user_hash); "#{user_hash[:firstname]}#{user_hash[:lastname]}".without_accent.gsub(/\s+/, "");		end

	def self.create_admin_user(password)
		User.where(firstname: "admin", lastname: "admin", login: "admin").first_or_create!(password: password)
	end
	def self.admin_user
    	find_by!(firstname: "admin", lastname: "admin", login: "admin")
	end
	def self.create_default_user(password)
		User.where(firstname: "default", lastname: "user", login: "default user").first_or_create!(password: password)
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

	def self.check_admin_password(password)
		BCrypt::Engine.hash_secret(password, admin_user[:salt]) == admin_user[:encrypted_password]
	end
	def self.check_default_password(password)
		BCrypt::Engine.hash_secret(password, default_user[:salt]) == default_user[:encrypted_password]
	end
  
  
  ##### EXPORT CSV
  
  ADDRESS_HEADER = ["Nom", "Prénom", "Rue", "Complément", "Ville", "Code postal", "Adresse internet", "Téléphone", "Nom", "Prénom", "Message"]
  RESPONSE_HEADER = ["Nom", "Prénom", "Cérémonie", "Cocktail", "Dinner", "Soirée", "Nom", "Prénom", "Cérémonie", "Cocktail", "Dinner", "Soirée", "Message"]
  
  def self.addresses
    CSV.generate( col_sep: ";") do |csv|
      csv << ADDRESS_HEADER
      User.where("town IS NOT NULL").all.each{ |user| csv << [user[:lastname], user[:firstname], user[:street], user[:address_add], user[:town], user[:zip_code], user[:email], user[:phone], user.partner.try(:lastname), user.partner.try(:firstname), user[:message_address],]} #
    end
  end
  def self.responses
    CSV.generate( col_sep: ";") do |csv|
      csv << RESPONSE_HEADER
      User.where("message_response != '--- {}\n'").all.each{ |user| csv << [user[:lastname], user[:firstname], user.wedding, user.cocktail, user.dinner, user.party, user.partner.try(:lastname), user.partner.try(:firstname), user.partner.try(:wedding), user.partner.try(:cocktail), user.partner.try(:dinner), user.partner.try(:party), user[:message_response],]} #
    end
  end
  
end
