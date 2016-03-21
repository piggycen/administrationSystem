# class Mycourse < ActiveRecord::Base
class Mycourse
	include Mongoid::Document
    include Mongoid::Timestamps
    include Mongoid::Paperclip

    field :mygrade, :type =>   Float
    field :mybugrade, :type =>   Float
    field :examtime, :type =>   DateTime
    field :examplace, :type =>   String
    field :buexamtime, :type =>   DateTime
    field :buexamplace, :type =>   String
    field :teaching_id, :type =>  String
    field :student_id, :type =>  String
    field :created_at, :type => DateTime
    field :updated_at, :type => DateTime
    field :star, :type => Integer



	belongs_to :student
	belongs_to :teaching

	# validates :teaching_id, uniqueness: true
	validates :teaching_id, presence: true
	validates :student_id, presence: true
    # validates :star, inclusion: { in: %w(1 2 3 4 5)}

    index({ teaching_id: 1, student_id: 1 }, { unique: true })
end
