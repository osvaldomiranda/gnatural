class AdminController < ApplicationController
  def index
    @mes = params[:mes] || '08-2018'
  end

  def vta_origen_toxls
    @mes = params[:mes] 

    sql = "SELECT upper(login) AS vta_origen,  CAST(create_date_order AS DATE) AS date , id_centro, nombre_centro, date_order, order_id, pos_reference, order_line_note, price_subtotal_incl FROM tablon2_anual WHERE login<>'cupones' AND login<>'cupon'  AND to_char(CAST(create_date_order AS DATE), 'MM-YYYY') = '#{@mes}'  ORDER BY id_centro, vta_origen, date_order"
    @array_vta_origen_xls = ActiveRecord::Base.connection.execute(sql).to_a   
    
    respond_to do |format|
      format.xls 
    end
  end

  def user_index
    @users = User.all.order(:email)
  end

  def reset_pass
    user = User.find(params[:user_id])
    user.password = 'gnatural'
    user.save
    @users = User.all.order(:email)
    redirect_to admin_user_index_path 
  end

  def kine_yield
    @id_centro = params[:center] || 1
    @nombre_centro = Center.where(id_centro:@id_centro ).first.nombre_centro

    @yields= Hash.new

    sql = " SELECT t.login AS vta_origen, k.hh_mensuales AS hh, to_char(date_trunc('month', CAST(t.create_date_order AS DATE)), 'YYYY-MM') AS date , sum(t.price_subtotal_incl) FROM tablon2_anual t, kinesiologists k WHERE upper(t.login) = upper(k.nombre) AND t.id_centro=#{@id_centro} AND CAST(t.create_date_order AS DATE) > date_trunc('month', CURRENT_DATE) - INTERVAL '13 months' GROUP BY vta_origen, hh, date ORDER BY date, vta_origen"
    array = ActiveRecord::Base.connection.execute(sql).to_a   


    kines = Kinesiologist.with_center(@id_centro)
    kines.each  do |kine|
      array_kine = array.map { |v| v if v["vta_origen"]=="#{kine.nombre}"}
      array_kine = array_kine.compact
      @yields["#{kine.nombre}"] = array_kine.map{|a| {a["date"]=>a["sum"].to_f/a["hh"].to_f}}
    end

  end
end
