class Student::PerinfosController < ApplicationController
	def percourse
		params.permit!
		@user = User.find_by(no: params[:user])
	end
	def exam
		params.permit!
		@user = User.find_by(no: params[:user])
	end
	def buexam
		params.permit!
		@user = User.find_by(no: params[:user])
	end
	def grade
		params.permit!
		@user = User.find_by(no: params[:user])
	end
end
