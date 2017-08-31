class EditUsersController < ApplicationController
    def edit
        password = params[:password]
        password_confirmation = params[:password_confirmation]
        
        c_u = User.where(name: params[:name]).take
        c_u.password=password
        c_u.password_confirmation=password_confirmation
        c_u.save
        
        redirect_to '/users/sign_in'
    end
    
end
