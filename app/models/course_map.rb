class CourseMap < ActiveRecord::Base
	#has_many :course_field_groups, :dependent => :destroy
	has_many :cm_cfships, :dependent => :destroy
	has_many :course_fields, :through => :cm_cfships, :dependent => :destroy
	has_many :course_groups, :dependent => :destroy
	has_many :user_coursemapships, :dependent => :destroy
	has_many :course_map_public_comments, :dependent => :destroy
	
	belongs_to :department
	delegate :ch_name, :to=>:department, :prefix=>true
	belongs_to :user
	
	def to_public_json
		{
			:id => self.id,
			#:name => course_map.department.ch_name+"入學年度:"+course_map.semester.year.to_s,
			:total_credit=>self.total_credit,
			:desc => self.desc,
			:cfs=>self.to_tree_json,
			:comments=>self.comments
		}
	end
	
	
	def to_tree_json
		self.course_fields.includes(:course_field_lists, :courses, :child_cfs, :cf_credits).map{|cf|
			cf.field_type < 3 ? cf.get_bottom_node : cf.get_middle_node
		}	
	end
	
	def comments
		return self.course_map_public_comments.order('updated_at DESC').map{|comment| comment.to_hash}
	end
end
