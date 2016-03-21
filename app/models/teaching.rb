# class Teaching < ActiveRecord::Base
class Teaching

	include Mongoid::Document
    include Mongoid::Timestamps
    include Mongoid::Paperclip
    
	field :teachtime, :type => Array
	field :teachplace, :type => String
	field :teacher_id, :type => Integer
	field :course_id, :type => Integer
	field :created_at, :type => DateTime
	field :updated_at, :type => DateTime

	# has_many :reschedules
	# has_many :clas, through: :reschedules
	belongs_to :teacher
	belongs_to :course
	has_many :mycourses, :class_name => "Mycourse"
	# has_many :students, through: :mycourses

	# validates :teachno, uniqueness: true
end
