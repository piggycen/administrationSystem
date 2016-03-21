class LoginsController < ApplicationController
  def login
  	session['loginedUser'] = nil
  end
  def checkLogin
  	params.permit!
  	@user = User.find_by(no: params[:user][:no])
  	if @user != nil && @user[:pwd] == params[:user][:pwd]
  		session['loginedUser'] = @user.no
  		case @user.role
  		when 'teacher'
			  redirect_to :controller => 'infos', :action => 'index', :user => @user.no
  		when 'admin'
  			redirect_to :controller => 'infos', :action => 'index', :user => @user.no 
  		else
  			redirect_to :controller => 'infos', :action => 'index', :user => @user.no
  		end
  	else
  		session['loginedUser'] = nil
  		redirect_to :controller => 'logins', :action => 'login'
  	end
  end
  def logout
  	session['loginedUser'] = nil
  end
end
