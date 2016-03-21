class Student::EvalueccorsController < ApplicationController
	def index
		params.permit!
		@user = User.find_by(no: params[:user])

		mycourses = Mycourse.where(:student_id => @user.id)
		@info = []
		mycourses.each do |mycourse|
			
			teaching = mycourse.teaching
			teacher = teaching.teacher
			course = teaching.course
			if course.ctype == 'C'
				hash = {}
				hash['tname'] = teacher.tname
				hash['cno'] = course.cno
				hash['cname'] = course.cname
				hash['ctype'] = '公选课'
				hash['credit'] = course.credit
				hash['status'] = mycourse.star ? true : false
				hash['courseid'] = course.id
				hash['teachingid'] = teaching.id
				@info.push(hash)
			end			
		end
	end
	def new
		params.permit!
		@user = User.find_by(no: params[:user])
		@student = Student.find_by(sno: params[:user])

		@mycourse = Mycourse.where(:teaching_id => params[:teachingid], :student_id => @student.id).first
		@teaching = @mycourse.teaching
		@course = @teaching.course
		@teacher = @teaching.teacher
	end
end