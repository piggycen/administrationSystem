class Admin::TeachersController < ApplicationController
	def index
		params.permit!
		@teacherall = Teacher.all
		@user = User.find_by(no: params[:user])
	end

	def new
		params.permit!
		@user = User.find_by(no: params[:user])
		@teacher = Teacher.new
	end

	def create
		params.permit!
		@user = User.find_by(no: params[:user])
		@teacher = Teacher.new(teacher_params)
		@teacher.department = Department.find(params[:department_id])
		if @teacher.save
			redirect_to admin_teachers_path(:user => @user.no)
		else
			render 'new'
		end
	end

	def edit
		params.permit!
		@user = User.find_by(no: params[:user])
		@teacher = Teacher.find(params[:id])
	end

	def update
		params.permit!
		@user = User.find_by(no: params[:user])
		@teacher = Teacher.find(params[:id])

		if @teacher.update(teacher_params)
		  @teacher.department = Department.find(params[:department_id])
		  @teacher.save
    	  redirect_to admin_teachers_path(:user => @user.no)
	  	else
	      render 'edit'
	  	end
		
	end

	def destroy
		params.permit!
		@user = User.find_by(no: params[:user])
	  	@teacher = Teacher.find(params[:id])
	  	@teacher.destroy
	 
	  	redirect_to admin_teachers_path(:user => @user.no)
	end

	private
		def teacher_params
	    	params.require(:teacher).permit(:tno, :tname, :tsex, :tbirthday, :tfunction, :tnation, :tplace, :tpassport)
	  	end
end
