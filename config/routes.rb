Apisystem::Application.routes.draw do
  # devise_for :users
  root 'logins#login'
  get "logins/index"
  get "logins/login"
  post "logins/checkLogin"
  get "logins/logout"
  namespace :admin do
    resources :teachers, :students, :schedules
  end

  # match 'infos', to: 'infos#index', as: :info, via: [:get, :update, :post]
  # match 'infos/edit', to: 'infos#edit', as: :edit, via: [:get, :post]
  resources :infos
  # match 'infos/change', to: 'infos#update', as: :change, via: [:patch, :post]
  # resources :logins
  # match 'student/', to: 'infos#edit', as: :edit, via: [:get, :post]
  namespace :student do
    resources :acourses, :bcourses, :ccourses, :dcourses, :tcourses, :scourses, :evalueacors, :evaluebcors, :evalueccors, :evaluedcors, :evaluescors, :evaluetcors
  end
  # 个人课表
  get 'student/mycourse', to: 'student/perinfos#percourse', as: :percourse

  # 学生考试查询
  get 'student/exam', to: 'student/perinfos#exam', as: :exam

  # 学生补考查询
  get 'student/buexam', to: 'student/perinfos#buexam', as: :buexam

  # 学生成绩查询
  get 'student/grade', to: 'student/perinfos#grade', as: :grade

  mount Api::V1::Server => '/api/v1', :as => 'api_v1'

  namespace :teacher do
    resources :grades
  end

  # 老师个人课表查询
  get 'teacher/mycourse', to: 'teacher/tcourse#index', as: :tcourse

end
