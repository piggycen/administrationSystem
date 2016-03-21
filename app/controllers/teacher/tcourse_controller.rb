class Teacher::TcourseController < ApplicationController
	def index
		params.permit!
		@user = User.find_by(no: params[:user])
	end
end
