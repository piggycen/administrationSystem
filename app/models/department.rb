# class Department < ActiveRecord::Base
class Department
	include Mongoid::Document
    include Mongoid::Timestamps
    include Mongoid::Paperclip

	field :dno, :type => String 
    field :dname, :type => String 
	field :created_at, :type => DateTime
	field :updated_at, :type => DateTime

	has_many :teachers, :class_name => "Teacher", dependent: :destroy
	has_many :majors, :class_name => "Major", dependent: :destroy
	
	validates :dno, uniqueness: true
end
