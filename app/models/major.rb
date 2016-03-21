# class Major < ActiveRecord::Base
class Major
	include Mongoid::Document
    include Mongoid::Timestamps
    include Mongoid::Paperclip

    field :mno, :type =>  String
    field :mname, :type =>  String
    field :department_id, :type =>  Integer
    field :created_at, :type => DateTime
    field :updated_at, :type => DateTime

	has_many :clas, :class_name => "Cla", dependent: :destroy
	belongs_to :department
	
	validates :mno, :uniqueness => {:scope => :department_id}
	validates :mno, presence: true
	validates :mno, length: { is: 5 }
	validates :mname, presence: true
end
