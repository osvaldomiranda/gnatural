class HomeController < ApplicationController
  before_filter :authenticate_user! 
  def index
  	
    @rut_centro = params[:center] 

    if @rut_centro.present?
      center = OwnerCenter.where(rut_centro: @rut_centro).first
      @nombre_centro = center.name_center
    else 
    	owner_center = current_user.owner_centers.order(:name_center).first
    	@rut_centro = owner_center.rut_centro 
    	@nombre_centro = owner_center.name_center 
    end  

    vta_total_mes = "SELECT rut_centro, sum(price_subtotal_incl) FROM tablon_mes WHERE rut_centro='#{@rut_centro}' GROUP BY rut_centro"
    array = ActiveRecord::Base.connection.execute(vta_total_mes).to_a
    @vta_total_mes = array.first["sum"].to_i

    #***************************

    vta_producto_mes = "SELECT  name_template, sum(price_subtotal_incl) FROM tablon_mes WHERE rut_centro='#{@rut_centro}' GROUP BY name_template "
    array = ActiveRecord::Base.connection.execute(vta_producto_mes).to_a
    @vta_producto_mes = array.map{|a| {a["name_template"]=>a["sum"]}}
    @vta_producto_mes = @vta_producto_mes.reduce({}, :merge)

    #***************************
  
    vta_diaria_total = "SELECT to_char(date_trunc('day', create_date_order), 'YYYY-MM-DD') AS date , sum(price_subtotal_incl) FROM tablon_mes WHERE rut_centro='#{@rut_centro}' GROUP BY date ORDER BY date "
    @array_vta_diaria_total = ActiveRecord::Base.connection.execute(vta_diaria_total).to_a 
    @vta_diaria_total = @array_vta_diaria_total.map{|a| {a["date"]=>a["sum"]}}
    @vta_diaria_total = @vta_diaria_total.reduce({}, :merge)

    #***************************

    vta_diaria_item = "SELECT name_template, to_char(date_trunc('day', create_date_order), 'YYYY-MM-DD') AS date , sum(price_subtotal_incl) FROM tablon_mes WHERE rut_centro='#{@rut_centro}' GROUP BY name_template,date ORDER BY name_template "
    @array_vta_diaria_item = ActiveRecord::Base.connection.execute(vta_diaria_item).to_a 
    @vta_diaria_item = @array_vta_diaria_item.map{|a| {[a["name_template"],a["date"]]=>a["sum"]}}
    @vta_diaria_item = @vta_diaria_item.reduce({}, :merge)

    #***************************

    vta_anual_item = "SELECT name_template, to_char(date_trunc('month', create_date_order), 'YYYY-MM-DD') AS date , sum(price_subtotal_incl) FROM tablon2_anual WHERE rut_centro='#{@rut_centro}' AND create_date_order > date_trunc('month', CURRENT_DATE) - INTERVAL '1 year'  GROUP BY name_template,date ORDER BY name_template "
    @vta_anual_item = ActiveRecord::Base.connection.execute(vta_anual_item).to_a 
    @vta_anual_item = @vta_anual_item.map{|a| {[a["name_template"],a["date"]]=>a["sum"]}}
    @vta_anual_item = @vta_anual_item.reduce({}, :merge)

    #***************************

    vta_anual = "SELECT  to_char(date_trunc('month', create_date_order), 'YYYY-MM-DD') AS date , sum(price_subtotal_incl) FROM tablon2_anual WHERE rut_centro='#{@rut_centro}' AND create_date_order > date_trunc('month', CURRENT_DATE) - INTERVAL '1 year' GROUP BY date ORDER BY date"
    @array_vta_anual = ActiveRecord::Base.connection.execute(vta_anual).to_a 
    @vta_anual = @array_vta_anual.map{|a| {a["date"]=>a["sum"]}}
    @vta_anual = @vta_anual.reduce({}, :merge)

    #**************************

    vta_origen_anual = " SELECT   CASE WHEN login='cupon' THEN 'Cupones' WHEN login='cupones'  THEN 'Cupones' ELSE 'Kines' END AS vta_origen, to_char(date_trunc('month', create_date_order), 'YYYY-MM-DD') AS date , sum(price_subtotal_incl) FROM tablon2_anual WHERE rut_centro='#{@rut_centro}' AND create_date_order > date_trunc('month', CURRENT_DATE) - INTERVAL '1 year' GROUP BY vta_origen, date"
    @array_vta_origen_anual = ActiveRecord::Base.connection.execute(vta_origen_anual).to_a 
    @vta_origen_anual = @array_vta_origen_anual.map{|a| {[a["vta_origen"],a["date"]]=>a["sum"]}}
    @vta_origen_anual = @vta_origen_anual.reduce({}, :merge)

  end
end
