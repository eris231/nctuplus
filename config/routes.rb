Nctuplus::Application.routes.draw do
	
	root :to => "main#index"
	
#--------- [devise] user account concerned --------------	
	devise_for :users, :skip=>[:registrations, :confirmations, :passwords],
             :controllers => { :omniauth_callbacks => "callbacks" },
             :path=>"/",
             :path_names => {
              :sign_in  => 'login',
              :sign_out => 'logout' }

	
#--------- events --------------	
	resources :events
	
#--------- old --------------	
 # match 'auth/:provider/callback', to: 'sessions#create', via: [:get, :post]
 # match 'auth/failure', to: redirect('/'), via: [:get, :post]
 # match 'signout', to: 'sessions#destroy', via: [:get, :post]
 # match 'signin', to: 'sessions#sign_in', via: [:get, :post]	
# get "sessions/get_courses"
	
	

#--------- for many usage --------------

	
	get "main/index"
 	post "main/temp_student_action"
	#get "main/E3Login"
	#post "main/E3Login_Check"
	get "main/student_import"
	post "main/student_import"
  get "main/test"
	post "main/send_report"
	get "main/policy_page"
  
#---------- admin page -----------
	
	get "admin/ee104"
	get "admin/users"
	post "admin/change_role"
	get "admin/course_maps" #, to: "course_maps#admin_index"
#---------- user ----------------
	
	get "user/add_course"
	get "user/delete_course"
	get "user/get_courses"
	get "user/this_sem"
	post "user/import_course"
	get "user/import_course"
	get "user/import_course_2"
	get "user/select_cs_cf"
	get "user/select_cm"
	post "user/select_cm"
	get "user/select_cf"
	
	get "user/statistics_table"

  get "user", to: "user#show"
	get "user/all_courses"
	get "user/statistics"
	post "user/select_dept"

	
#--------- user end -------------
	post "course_content/raider"
	get "course_content/raider"	
	get "course_content/raider_list_like"
	get "course_content/rate_cts"
	get "course_content/get_compare"	
	###
	get "course_content/get_course_info"
	#get "course_content/show" # testing
	post "course_content/course_action"

	resources :courses, :only => [:index, :show] do
		collection do
			get "index_new"
			get "search_mini"
			get "search_mini_cm"
			get "simulation"
			get "export_timetable"
	#		get "add_to_cart"
	#		get "show_cart"
		end
	end
	
	resources :course_maps, :except=>[:edit] do
	  collection do
	    	get "get_course_tree"
	      get "get_group_tree"
	      get "show_course_list" 
	      get "show_course_group_list"
	      get "get_credit_list"
	      post "credit_action"
	      post "course_action"
        post "action_new"
        post "action_update"
        post "action_delete"	
        post "action_fchange"
        post "course_group_action"
        get "content"
        post "update_cm_head"
        get "public"
        post "cm_public_comment_action"
	  end
	end

	resources :departments, :except=>[:show, :destroy]
	
	
	get "discusses/show"
	get "discusses/like"
	post "discusses/new"
	post "discusses/update"
	post "discusses/delete"
 

	
	# for ems curl
	post "/main/get_specified_classroom_schedule"
	
	#----------for chrome extension---------------
	post "api/query_from_time_table"
	post "api/query_from_cos_adm"
	get "api/testttt"
	
  #----------for files---------------
  resources :past_exams, :except=>[:update] do
		collection do
			get "list_by_ct"
			get "edit"
		end
	end
  
    

end
