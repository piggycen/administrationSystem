module Api::V1::PercourseController
	def self.registered(app)
		app.helpers Helpers

		#个人课表数据查询
		app.get '/student/percourse' do
			user = User.find_by(no: params[:user])
			mycourses = Mycourse.where(:student_id => user.id)

			items = []
			if mycourses
				mycourses.each do |mycourse|
					perinfo = {}
					teaching = Teaching.find(mycourse.teaching_id)
					perinfo['teachtime'] = teaching.teachtime
					perinfo['teachplace'] = teaching.teachplace

					course = teaching.course
					perinfo['cname'] = course.cname

					teacher = teaching.teacher
					perinfo['tname'] = teacher.tname
					items << perinfo
				end
			end
			render_json(:data => items)
		end

		#初次选课
		app.get '/student/choose' do
			@user = User.find_by(no: params[:user])
			@student = Student.find_by(:sno => params[:user])
			@teaching = Teaching.find(params[:teaching])

			@course = @teaching.course

			@teachingall = Teaching.where(:course_id => params[:courseid])

			items = []
			for i in 0..(@teachingall.count-1)
				flag = {}
				if !(@teachingall[i].mycourses).blank?					
					flag['test'] = true
					break
				else
					flag['test'] = false
				end
			end
				items << flag
			if flag['test'] == false	
				@mycourse = Mycourse.new(teaching_id: params[:teaching], student_id: @student.id)
				if @mycourse.save!
					Rails.logger.info("logger Save OK")
				else
					Rails.logger.error("logger Save ERROR")
				end
			end
			render_json(:data => items)
		end

		#删除选课
		app.get '/student/destroy' do
			@user = User.find_by(no: params[:user])
			@teaching = Teaching.find(params[:teachingid])

			@mycourse = Mycourse.where(:teaching_id => params[:teachingid], :student_id => @user.id)

			items = []
			flag = {}
			if !@mycourse.blank?
				@mycourse.destroy
				flag['destroy'] = 'true'
			else
				flag['destroy'] = 'false'
			end
			items << flag
			render_json(:data => items)
		end

		# 学生考试查询
		app.get '/student/exam' do
			@user = User.find_by(no: params[:user])
			mycourseall = Mycourse.where(:student_id => @user.id)
			student = Student.find_by(:sno => params[:user])

			items = []
			
			if !mycourseall.blank?
				mycourseall.each do |exam|
					info = {}
					teaching = Teaching.find(exam.teaching_id)
					teacher = teaching.teacher
					course = teaching.course
					info['cno'] = course.cno
					info['cname'] = course.cname
					info['sno'] = student.sno
					info['sname'] = student.sname
					info['examtime'] = '' || exam.examtime
					info['examplace'] = '' || exam.examplace
					items << info
				end
			end
			render_json(:data => items)
		end

		# 学生补考查询
		app.get '/student/buexam' do
			@user = User.find_by(no: params[:user])
			mycourseall = Mycourse.where(:student_id => @user.id)
			student = Student.find_by(:sno => params[:user])

			items = []
			
			if !mycourseall.blank?
				mycourseall.each do |buexam|
					if !buexam.mybugrade.blank? && (buexam.mybugrade < 60)
						info = {}
						teaching = Teaching.find(buexam.teaching_id)
						teacher = teaching.teacher
						course = teaching.course
						info['cno'] = course.cno
						info['cname'] = course.cname
						info['sno'] = student.sno
						info['sname'] = student.sname
						info['buexamtime'] = '' || buexam.buexamtime
						info['buexamplace'] = '' || buexam.buexamplace
						items << info
					end
				end
			end
			render_json(:data => items)
		end

		# 学生成绩查询
		app.get '/student/grade' do
			@user = User.find_by(no: params[:user])
			mycourseall = Mycourse.where(:student_id => @user.id)
			student = Student.find_by(:sno => params[:user])

			items = []
			
			if !mycourseall.blank?
				mycourseall.each do |grade|
					info = {}
					teaching = Teaching.find(grade.teaching_id)
					teacher = teaching.teacher
					course = teaching.course
					info['cno'] = course.cno
					info['cname'] = course.cname
					case course.ctype
					when 'A'
						info['ctype'] = '公共必修课'
					when 'B'
						info['ctype'] = '限选课'
					when 'C'
						info['ctype'] = '公共选修课'
					when 'D'
						info['ctype'] = '实验课'
					when 'S'
						info['ctype'] = '实践课'
					when "T"
						info['ctype'] = '体育课'
					end
					info['credit'] = course.credit
					info['mygrade'] = '' || grade.mygrade
					info['mybugrade'] = '' || grade.mybugrade

					items << info
				end
			end
			render_json(:data => items)
		end

		app.get '/student/evalue' do
			@user = User.find_by(no: params[:user])
			@student = Student.find_by(sno: params[:user])
			mycourse = Mycourse.where(:teaching_id => params[:teachingid], :student_id => @student.id).first

			items = []
			if !mycourse.blank?
				flag = {}
				if mycourse.star.blank?
					mycourse.star = params[:star]
					if mycourse.save
						flag['evalue'] = true
					else
						flag['evalue'] = false
					end
				else
					flag['evalue'] = true
				end
					items << flag
					render_json(:data => items)
			end
		end
	end

		

	 module Helpers
        def render_json(json={})
            JSON.generate({:status => 0, :msg => "success."}.merge(json))
        end
    end
end
