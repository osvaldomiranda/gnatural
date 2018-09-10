class PlanyoController < ApplicationController
  def index
  
  	@mes = params[:mes] || Date.today.strftime("%m-%Y")
  	date = Date.parse("1-#{@mes}")

  	@month = date.month
  	@year = date.year
  end
end
