# encoding: utf-8
class Api::V1::HomeController < ApplicationController
  protect_from_forgery
  # respond_to :json

  def index
    access_token = params[:token] 

    if access_token.present?
      user = User.where(access_token: access_token).first
      owner_center = user.owner_centers.order(:name_center).first
      id_centro = owner_center.id_centro 
      rut_centro = owner_center.rut_centro 
      nombre_centro = owner_center.name_center 

      sql = "SELECT * FROM hora_act"
      array =  ActiveRecord::Base.connection.execute(sql).to_a
      hora_act = DateTime.parse(array.last["hora"])

      vta_total_mes = "SELECT id_centro, sum(price_subtotal_incl) FROM tablon_mes WHERE id_centro=#{@id_centro} GROUP BY id_centro"
      array = ActiveRecord::Base.connection.execute(vta_total_mes).to_a
      if array.count > 0
        vta_total_mes = array.first["sum"].to_i
      else
        vta_total_mes = 0
      end  

      render :json=> {id_centro: id_centro, rut_centro: rut_centro, nombre_centro: nombre_centro, vta_total_mes: vta_total_mes, hora_act: hora_act} , :status => :ok
    else 
      render :json=> {} , :status => :unauthorized
    end  
  end

  def centers
    access_token = params[:token] 

    if access_token.present?
      user = User.where(access_token: access_token).first
      centers = OwnerCenter.where(user_id: user.id).order(:name_center).map{|t| [t.name_center, t.id_centro]}
      render :json=> {centers: centers} , :status => :ok
    else
      render :json=> {} , :status => :unauthorized
    end  
  end

end  