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

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
  end
end
