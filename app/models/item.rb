class Item < ActiveRecord::Base
	validates_presence_of :name,:discription, :price, :category
	has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100#" }, :default_url => "/images/:style/missing.png"
    validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
	belongs_to :category
	has_one :order
	attr_accessor  :cardnumber_1, :cardnumber_2, :cardnumber_3, :cardnumber_4, :cardnumber_5, :first_name, :last_name, :card_type, :card_expires_on, :address, :city, :state, :country, :zipcode, :phone_no

end
