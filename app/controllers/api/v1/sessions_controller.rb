# encoding: utf-8
class Api::V1::SessionsController < ApplicationController
  protect_from_forgery
  # respond_to :json

  def login
    headers['Access-Control-Allow-Origin'] = "*"
      
    user = User.find_by_email(params[:username])

    if user.present?
      if user.valid_password?(params[:password])
        user.regenerate_access_token
        #responde con el token generado del customer_user
        render :json=> {username: user.email, token: user.access_token, id: user.id } , :status => :ok
      else
        invalid_login_attempt
      end  
    end    
  end

  def logout
    render :json=> {status: 'ok'} , :status => :ok
  end

  def options
    headers['Access-Control-Allow-Origin'] = request.env['HTTP_ORIGIN']
    headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
    headers['Access-Control-Max-Age'] = '1000'
    headers['Access-Control-Allow-Headers'] = '*,x-requested-with'
    head :ok
  end

  private
  def invalid_login_attempt
    render :json=> {:message=>"Error with your authentication"}, :status=>401
  end


end