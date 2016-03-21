# class Cla < ActiveRecord::Base
class Cla
	include Mongoid::Document
    include Mongoid::Timestamps
    include Mongoid::Paperclip

	field :clno, :type => String
	field :clname, :type => String
	field :major_id, :type => Integer
	field :created_at, :type => DateTime
	field :updated_at, :type => DateTime

	has_many :students, :class_name => "Student", dependent: :destroy
	belongs_to :major
	# has_many :reschedules

	# has_many :teachings, through: :reschedules
	
	validates :clno, :uniqueness => {:scope => :major_id}
	validates :clno, presence: true
	validates :clno, length: { is: 6 }
	validates :clname, presence: true

end
