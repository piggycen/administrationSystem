# class Teacher < ActiveRecord::Base
class Teacher < User
	include Mongoid::Document
	# rolify
    include Mongoid::Timestamps
    include Mongoid::Paperclip

    # resourcify

	field :tno, :type => String
	field :tname, :type => String
	field :tsex, :type => String
	field :tbirthday, :type => Date
	field :tfunction, :type => String
	field :tplace, :type => String
	field :tnation, :type => String
	field :tpassport, :type => String
	field :department_id, :type => Integer
	field :created_at, :type => DateTime
	field :updated_at, :type => DateTime

	belongs_to :department
	has_many :teachings, :class_name => "Teaching"
	# has_many :courses, through: :teachings

	# validates :tno, :uniqueness => {:scope => :department_id}
	# validates :tno, presence: true
	# validates :tno, length: { is: 6 }
	# validates :tname, presence: true
	# validates :tpassport, length: { is: 18 }
	# validates :tfunction, inclusion: { in: %w(助教 讲师 副教授 教授),
 #    message: "%{value}不符合规则,请从助教、讲师、副教授和教授中选一个" }
end
