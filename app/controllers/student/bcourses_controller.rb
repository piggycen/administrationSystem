# class Student::BcoursesController < ApplicationController
# 	def index
# 		params.permit!
# 		@user = User.find_by(no: params[:user])
# 		@bcourseall = Course.where(:ctype => "B")
# 	end
# 	def new
# 		params.permit!
# 		@user = User.find_by(no: params[:user])
# 		@mycourse = Mycourse.new

# 		@bcourse = Course.find(params[:courseid])
# 		@teaching = Teaching.where(:course_id => params[:courseid])
# 		@teachtime = Teaching.where(:course_id => params[:courseid]).pluck(:teachtime)
# 		@teachplace = Teaching.where(:course_id => params[:courseid]).pluck(:teachplace)
# 		# @teacher
# 	end
# 	def create
# 		params.permit!
# 		@user = User.find_by(no: params[:user])
# 		@student = Student.find_by(:sno => params[:user])
# 		@mycourse = Mycourse.new(teaching_id: params[:teaching], student_id: @student.id)
# 		if @mycourse.save
# 			redirect_to student_bcourses_path(:user => @user.no)
# 		else
# 			render 'new'
# 		end
# 	end
# 	def edit
# 		params.permit!
# 		@user = User.find_by(no: params[:user])
# 		@student = Student.find_by(:sno => params[:user])
# 		@mycourse = Mycourse.new

# 		@bcourse = Course.find(params[:id])
# 		@teaching = Teaching.where(:course_id => params[:id])
# 		@teachtime = Teaching.where(:course_id => params[:id]).pluck(:teachtime)
# 		@teachplace = Teaching.where(:course_id => params[:id]).pluck(:teachplace)
# 	end
# 	def update
# 		params.permit!
# 		@user = User.find_by(no: params[:user])
# 		@student = Student.find_by(:sno => params[:user])
# 		@bcourse = Course.find(params[:courseid])
# 		@teaching = Teaching.find_by(:course_id => params[:courseid])
# 		@mycourse = Mycourse.find_by(:teaching_id => @teaching.id)

# 		if @mycourse.update(:teaching_id => params[:teaching], :student_id => @student.id)
# 			redirect_to student_bcourses_path(:user => @user.no)
# 		else
# 			render 'edit'
# 		end
# 	end
# 	def destroy
# 		params.permit!
# 		@user = User.find_by(no: params[:user])
# 		@student = Student.find_by(:sno => params[:user])
# 		# @mycourse
# 	end
# end
class Student::BcoursesController < ApplicationController
	def index
		params.permit!
		@user = User.find_by(no: params[:user])
		@acourseall = Course.where(:ctype => "B")
	end
	def new
		params.permit!
		@user = User.find_by(no: params[:user])
		@student = Student.find_by(:sno => params[:user])
		@acourse = Course.find(params[:courseid])
		@teaching = []
		teaching = Teaching.where(:course_id => params[:courseid])
		
		
		teaching.each do |t|
			hash = {}
			# byebug
			teacher = Teacher.find(t.teacher_id)
			@mycourse = Mycourse.where(:teaching_id => t.id, :student_id => @user.id)		
			# if @mycourse.blank?
				hash['teachingid'] = t.id
				hash['cname'] = @acourse.cname
				hash['cno'] = @acourse.cno
				hash['credit'] = @acourse.credit
				hash['tname'] = teacher.tname
				hash['dname'] = teacher.department.dname
				hash['teachtime'] = t.teachtime
				hash['teachplace'] = t.teachplace
				hash['status'] = @mycourse.first ? true : false
				# byebug
			# end
			@teaching.push(hash)
			# byebug
		end
	end
	# def edit
	# 	params.permit!
	# 	@user = User.find_by(no: params[:user])
	# 	@student = Student.find_by(:sno => params[:user])
	# 	@mycourse = Mycourse.new

	# 	@acourse = Course.find(params[:id])
	# 	@teaching = Teaching.where(:course_id => params[:id])
	# 	@teachtime = Teaching.where(:course_id => params[:id]).pluck(:teachtime)
	# 	@teachplace = Teaching.where(:course_id => params[:id]).pluck(:teachplace)
	# end
	# def update
	# 	params.permit!
	# 	@user = User.find_by(no: params[:user])
	# 	@student = Student.find_by(:sno => params[:user])
	# 	@acourse = Course.find(params[:courseid])
	# 	@teaching = Teaching.find_by(:course_id => params[:courseid])
	# 	@mycourse = Mycourse.find_by(:teaching_id => @teaching.id)

	# 	if @mycourse.update(:teaching_id => params[:teaching], :student_id => @student.id)
	# 		redirect_to student_acourses_path(:user => @user.no)
	# 	else
	# 		render 'edit'
	# 	end
	# end
	# def destroy
	# 	params.permit!
	# 	@user = User.find_by(no: params[:user])
	# 	@student = Student.find_by(:sno => params[:user])
	# 	# @mycourse
	# end
end
