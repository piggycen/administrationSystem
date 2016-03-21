# class Student < ActiveRecord::Base
class Student < User
	include Mongoid::Document
	# rolify
    include Mongoid::Timestamps
    include Mongoid::Paperclip

    # resourcify
    
	field :sno, :type => String
	field :sname, :type => String
	field :ssex, :type => String
	field :sbirthday, :type => Date
	field :splace, :type => String
	field :spassport, :type => String
	field :sgetin, :type => String
	field :schooling, :type => String
	field :snation, :type => String
	field :cla_id, :type => Integer
	field :created_at, :type => DateTime
	field :updated_at, :type => DateTime


	belongs_to :cla
	has_many :mycourses, :class_name => "Mycourse"
	# has_many :teachings, through: :mycourses
	
	validates :sno, :uniqueness => {:scope => :cla_id}
	validates :sno, presence: true
	validates :sno, length: { is: 8 }
	validates :sname, presence: true
	validates :spassport, length: { is: 18 }
end