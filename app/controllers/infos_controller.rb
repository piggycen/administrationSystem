class InfosController < ApplicationController
	def index
		params.permit!
		@user = User.find_by(no: params[:user])
		if !@user.blank?
			case @user.role
	  		when 'teacher'
				@info = Teacher.find_by(tno: @user.no)
	  		when 'admin'
	  			@info = Teacher.find_by(tno: @user.no)
	  		else
	  			@info = Student.find_by(sno: @user.no)
	  		end
	  	else
	  		session['loginUser'] = nil
	  		redirect_to :controller => 'logins',:action => 'login'
	  	end
	end
	def edit
		params.permit!
		@user = User.find_by(no: params[:user])
	end
	def update
		params.permit!
		@user = User.find_by(no: params[:user])

		if @user.pwd == params[:pwd]
			if params[:newpwd] == params[:confirmpwd]
				if @user.update(:pwd => params[:confirmpwd])
					@user.save
					redirect_to infos_path(:user => @user.no)
	  			else
	      			render 'edit'
	      		end
	      	else
	      		render 'edit'
	      	end
	    else
	      	render 'edit'
	  	end		
	end
end
