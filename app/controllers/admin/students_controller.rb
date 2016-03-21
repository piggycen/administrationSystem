class Admin::StudentsController < ApplicationController
	def index
		params.permit!
		@studentall = Student.all
		@user = User.find_by(no: params[:user])
	end

	def new
		params.permit!
		@user = User.find_by(no: params[:user])
		@student = Student.new
	end

	def create
		params.permit!
		@user = User.find_by(no: params[:user])
		@student = Student.new(student_params)
		@student.cla = Cla.find(params[:cla_id])
		@student.cla.major = Major.find(params[:major_id])
		@student.cla.major.department = Department.find(params[:department_id])

		if @student.save
			redirect_to admin_students_path(:user => @user.no)
		else
			render 'new'
		end
	end

	def edit
		params.permit!
		@user = User.find_by(no: params[:user])
		@student = Student.find(params[:id])
	end

	def update
		params.permit!
		@user = User.find_by(no: params[:user])
		@student = Student.find(params[:id])

		if @student.update(student_params)
		  @student.cla = Cla.find(params[:cla_id])
		  @student.save
    	  redirect_to admin_students_path(:user => @user.no)
	  	else
	      render 'edit'
	  	end
		
	end

	def destroy
		params.permit!
		@user = User.find_by(no: params[:user])
	  	@student = Student.find(params[:id])
	  	@student.destroy
	 
	  	redirect_to admin_students_path(:user => @user.no)
	end

	private
		def student_params
	    	params.require(:student).permit(:sno, :sname, :ssex, :sbirthday, :splace, :spassport, :sgetin, :schooling, :snation)
		end
end
