class AuthE3 < ActiveRecord::Base
  belongs_to :user
  
  def to_json
    {
      :student_id=> self.student_id
    }
  end
  
  def self.from_omniauth(student_id, password, current_user)
    if !student_id or !password
      return {:auth=>false, :message=>"請輸入帳號密碼"}
    end
    data = E3Service.login(student_id, password)
    if data[:auth]
      auth_e3 = where(:student_id=>student_id).first_or_initialize.tap do |e|
        e.student_id=student_id       
        if not e.user_id
          if not current_user.presence
            user = User.create_from_auth({
              :provider=>"e3",
              :name=>student_id,
              :password=>Devise.friendly_token[0,20],
              :email=>"#{Devise.friendly_token[0,8]}@please.change.me"
            })
            e.user_id = user.id
          else
            e.user_id = current_user.id # binding
          end  
        elsif current_user
          return {:auth=>false, :message=>"此認證帳號已被使用"}
        end 
        e.save!
      end
      return {:auth=>true, :user=>auth_e3.user}     
    else
      return {:auth=>false, :message=>"認證失敗"}
    end
  end
  
end
