module Api::V1::TeacherController
	def self.registered(app)
		app.helpers Helpers

		#老师个人课表数据查询
		app.get '/teacher/percourse' do
			user = User.find_by(no: params[:user])
			teacher = Teacher.find_by(tno: params[:user])
			teachings = Teaching.where(:teacher_id => teacher.id)

			items = []
			if teachings
				teachings.each do |teaching|
					perinfo = {}
					course = teaching.course
					perinfo['cno'] = course.cno
					perinfo['cname'] = course.cname
					perinfo['credit'] = course.credit
					perinfo['cid'] = course.id.to_s
					perinfo['teachingid'] = teaching.id.to_s
					case course.ctype
					when 'A'
						perinfo['ctype'] = '必修课'
					when 'B'
						perinfo['ctype'] = '限选课'
					when 'C'
						perinfo['ctype'] = '公选课'
					when 'D'
						perinfo['ctype'] = '实验课'
					when 'S'
						perinfo['ctype'] = '实践课'
					when 'T'
						perinfo['ctype'] = '体育课'
					end
					perinfo['teachtime'] = teaching.teachtime
					perinfo['teachplace'] = teaching.teachplace
					
					items << perinfo
				end
			end
			render_json(:data => items)
		end	

		app.get '/teacher/grade' do
			user = User.find_by(no: params[:user])
			teacher = Teacher.find_by(tno: params[:user])
			mycourses = Mycourse.where(:teaching_id => params[:teachingid])

			items = []
			mycourses.each do |mycourse|
				perinfo = {}
				student = mycourse.student
				cla = student.cla
				major = cla.major
				department = major.department
				perinfo['sno'] = student.sno
				perinfo['sname'] = student.sname
				perinfo['clno'] = cla.clno
				perinfo['mname'] = major.mname
				perinfo['dname'] = department.dname
				items << perinfo
			end
			# course = Course.find(params[:courseid])

			# teachings = Teaching.where(:course_id => params[:courseid])

			# items = []
			# teachings.each do |teaching|
			# 	perinfo = {}
			# 	mycourses = teaching.mycourses
			# 	mycourses.each do |mycourse|
			# 		student = mycourse.student
			# 		cla = student.cla
			# 		major = cla.major
			# 		department = major.department
			# 		perinfo['sno'] = student.sno
			# 		perinfo['sname'] = student.sname
			# 		perinfo['clno'] = cla.clno
			# 		perinfo['mname'] = major.mname
			# 		perinfo['dname'] = department.dname
			# 	end
			# end
			render_json(:data => items)
		end
	end



		

	 module Helpers
        def render_json(json={})
            JSON.generate({:status => 0, :msg => "success."}.merge(json))
        end
    end
end
