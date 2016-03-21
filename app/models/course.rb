# class Course < ActiveRecord::Base
class Course
	include Mongoid::Document
    include Mongoid::Timestamps
    include Mongoid::Paperclip

    field :cno, :type => String 
    field :cname, :type => String 
    field :credit, :type => String 
    field :ctype, :type => String 
    field :created_at, :type => DateTime 
    field :updated_at, :type => DateTime 

	has_many :teachings, :class_name => "Teaching"
	# has_many :teachers, through: :teachings

	validates :cno, uniqueness: true 
	validates :cno, length: { is: 8 }
end


