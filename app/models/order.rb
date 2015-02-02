class Order < ActiveRecord::Base
  belongs_to :item
  has_many :transactions, :class_name => "OrderTransaction"
  # validates_presence_of :cardnumber_1, :cardnumber_2, :cardnumber_3, :cardnumber_4, :cardnumber_5, :first_name, :last_name, :card_type, :card_expires_on, :address, :city, :state, :country, :zipcode, :phone_no
  # attr_accessor  :cardnumber_1, :cardnumber_2, :cardnumber_3, :cardnumber_4, :cardnumber_5, :first_name, :last_name, :card_type, :card_expires_on, :address, :city, :state, :country, :zipcode, :phone_no




end
