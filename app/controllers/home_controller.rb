class HomeController < ApplicationController
  before_filter :authenticate_user! 
  def index

    conn2 = {:adapter=>"postgresql", :encoding=>"utf8", :database=>"ZDM",:host =>"190.196.178.105" , :port=>7001, :user=> "marcelo", :password => "godo2018" }
    sql = "SELECT name_template, sum(price_subtotal_incl) FROM tablon_mes WHERE nombre_centro='Almabella_17' GROUP BY name_template "
    array = ActiveRecord::Base.establish_connection(conn2).connection.execute(sql).to_a

    @chart_data = array.map{|a| {a["name_template"]=>a["sum"]}}

    @chart_data = @chart_data.reduce({}, :merge)

    @chart_data = User.group(:email).count 
  end
end
