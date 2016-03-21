# class Teaching < ActiveRecord::Base
class User

	include Mongoid::Document
    include Mongoid::Timestamps
    include Mongoid::Paperclip
    
	field :no, :type => String
	field :pwd, :type => String
	field :role, :type => String
	
end