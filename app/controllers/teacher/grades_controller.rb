class Teacher::GradesController < ApplicationController
	def index
		params.permit!
		@user = User.find_by(no: params[:user])
	end
	def new
		params.permit!
		@user = User.find_by(no: params[:user])
		@teacher = Teacher.find_by(tno: params[:user])
		@course = Course.find(params[:courseid])

		# @teachings = []
		# teachings = Teaching.where(:teacher_id => @teacher.id, :course_id => @course.id)
		# teachings.each do |teaching|
		# 	hash = {}
		# 	course = teaching.course
		# 	hash['cno'] = course.cno
		# 	hash['cname'] = course.cname
		# 	hash['credit'] = course.credit
		# 	hash['cid'] = course.id.to_s
		# 	hash['credit'] = course.credit
		# 	hash['teachtime'] = teaching.teachtime
		# 	hash['teachplace'] = teaching.teachplace
		# end
		# @teachings.push(hash)
	end
end