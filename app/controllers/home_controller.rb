class HomeController < ApplicationController
  before_filter :authenticate_user! 
  def index

  	owner_center = current_user.owner_centers.first
  	@rut_centro = owner_center.rut_centro || nil
  	@nombre_centro = owner_center.name_center || nil

  	# SELECT create_date_order, nombre_centro, login, name_template, price_subtotal_incl FROM tablon_mes;

    conn2 = {:adapter=>"postgresql", :encoding=>"utf8", :database=>"ZDM",:host =>"190.196.178.105" , :port=>7001, :user=> "marcelo", :password => "godo2018" }
    

    vta_producto_mes = "SELECT  name_template, sum(price_subtotal_incl) FROM tablon_mes WHERE rut_centro='#{@rut_centro}' GROUP BY name_template "
    array = ActiveRecord::Base.establish_connection(conn2).connection.execute(vta_producto_mes).to_a
  #  array = ActiveRecord::Base.establish_connection(conn2).connection.execute(vta_producto_mes).to_a 
    @vta_producto_mes = array.map{|a| {a["name_template"]=>a["sum"]}}
    @vta_producto_mes = @vta_producto_mes.reduce({}, :merge)


    #***************************
  
    vta_diaria_total = "SELECT to_char(date_trunc('day', create_date_order), 'YYYY-MM-DD') AS date , sum(price_subtotal_incl) FROM tablon_mes WHERE rut_centro='#{@rut_centro}' GROUP BY date ORDER BY date "
  #  array = ActiveRecord::Base.establish_connection(conn2).connection.execute(sql).to_a
    @array_vta_diaria_total = ActiveRecord::Base.establish_connection(conn2).connection.execute(vta_diaria_total).to_a 
    @vta_diaria_total = @array_vta_diaria_total.map{|a| {a["date"]=>a["sum"]}}
    @vta_diaria_total = @vta_diaria_total.reduce({}, :merge)

    #***************************



    vta_diaria_item = "SELECT name_template, to_char(date_trunc('day', create_date_order), 'YYYY-MM-DD') AS date , sum(price_subtotal_incl) FROM tablon_mes WHERE rut_centro='#{@rut_centro}' GROUP BY name_template,date ORDER BY name_template "
    @array_vta_diaria_item = ActiveRecord::Base.establish_connection(conn2).connection.execute(vta_diaria_item).to_a 
    @vta_diaria_item = @array_vta_diaria_item.map{|a| {[a["name_template"],a["date"]]=>a["sum"]}}
    @vta_diaria_item = @vta_diaria_item.reduce({}, :merge)

    #***************************

    vta_anual = "SELECT  to_char(date_trunc('month', create_date_order), 'YYYY-MM-DD') AS date , sum(price_subtotal_incl) FROM tablon2_anual WHERE rut_centro='#{@rut_centro}' AND create_date_order > date_trunc('month', CURRENT_DATE) - INTERVAL '1 year' GROUP BY date ORDER BY date"
    @array_vta_anual = ActiveRecord::Base.establish_connection(conn2).connection.execute(vta_anual).to_a 
    @vta_anual = @array_vta_anual.map{|a| {a["date"]=>a["sum"]}}
    @vta_anual = @vta_anual.reduce({}, :merge)

    #**************************

    vta_origen_anual = " SELECT   CASE WHEN login='cupon' THEN 'Cupones' WHEN login='cupones'  THEN 'Cupones' ELSE 'Kines' END AS vta_origen, to_char(date_trunc('month', create_date_order), 'YYYY-MM-DD') AS date , sum(price_subtotal_incl) FROM tablon2_anual WHERE rut_centro='#{@rut_centro}' AND create_date_order > date_trunc('month', CURRENT_DATE) - INTERVAL '1 year' GROUP BY vta_origen, date"
    @array_vta_origen_anual = ActiveRecord::Base.establish_connection(conn2).connection.execute(vta_origen_anual).to_a 
    @vta_origen_anual = @array_vta_origen_anual.map{|a| {[a["vta_origen"],a["date"]]=>a["sum"]}}
    @vta_origen_anual = @vta_origen_anual.reduce({}, :merge)
  end
end
