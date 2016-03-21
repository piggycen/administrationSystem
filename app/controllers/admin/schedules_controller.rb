class Admin::SchedulesController < ApplicationController
	def index
		params.permit!
		@user = User.find_by(no: params[:user])
		@teachingall = Teaching.all
	end
	def new
		params.permit!
		@user = User.find_by(no: params[:user])
		@teaching = Teaching.new
	end
	def create
		params.permit!
		@user = User.find_by(no: params[:user])
		@teachingall = Teaching.all
		@teaching = Teaching.new()
		@teaching[:teachtime] = params[:teachtime].split(',')
		@teaching[:teachplace] = params[:teachplace]
		@course = Course.find_by(id: params[:course_id])
		@teacher = Teacher.find_by(id: params[:teacher_id])

		@teaching.course = @course
		@teaching.teacher = @teacher

		if @teaching.save
			redirect_to admin_schedules_path(:user => @user.no)
		else
			render 'new'
		end
	end

	def edit
		params.permit!
		@user = User.find_by(no: params[:user])
		@teaching = Teaching.find(params[:id])
		@teacher = Teacher.find(@teaching.teacher_id)
		@course = Course.find(@teaching.course_id)
	end

	def update
		params.permit!
		@user = User.find_by(no: params[:user])
		@teaching = Teaching.find(params[:id])
		@teaching[:teachtime] = params[:teaching][:teachtime].split(',')
		if @teaching.update(teaching_params)
    	  redirect_to admin_schedules_path(:user => @user.no)
	  	else
	      render 'edit'
	  	end
	end
	def destroy
		params.permit!
		@user = User.find_by(no: params[:user])
	  	@teaching = Teaching.find(params[:id])
	  	@teaching.destroy
	 
	  	redirect_to admin_schedules_path(:user => @user.no)
	end

	private
	  def teaching_params
	    params.require(:teaching).permit(:teachplace)
	  end
end
