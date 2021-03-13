require 'rails_helper'

module TestHelper

    def is_logged_in?
        !session[:user_id].nil?
    end 

    def log_in_as(user)
        visit login_path

        fill_in "session_email",with: user.email
        fill_in "session_password",with: user.password
        find('input[name="commit"]').click    
    end 
    
        #postを使う処理はリクエストスペック、システムスペックではfill_in ~を使う
#     def log_in(user,remember_me)
#         post login_path,params: { session: { email: user.email,password: user.password,remember_me: remember_me }}
#     end 
end

