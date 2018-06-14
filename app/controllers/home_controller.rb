class HomeController < ApplicationController
  before_filter :authenticate_user! 
  def index
    @chart_data = User.group(:email).count 
  end
end
