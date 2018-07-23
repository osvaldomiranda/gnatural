class Api::V1::OwnerCentersController < ApplicationController
  protect_from_forgery exception: :actualize_center

  def actualize_center
    centers = "SELECT * FROM centros"
    array = ActiveRecord::Base.connection.execute(centers).to_a

    array.each do |f|
      oc = OwnerCenter.where(user_id:1, id_centro: f["id_centro"]).first
      unless oc.present?
        oc = OwnerCenter.new
        oc.user_id = 1
        oc.rut_centro = f["rut_centro"]
        oc.name_center = f["nombre_centro"]
        oc.id_centro  = f["id_centro"]
        oc.save
      end

      oc = OwnerCenter.where(user_id:37, id_centro: f["id_centro"]).first
      unless oc.present?
        oc = OwnerCenter.new
        oc.user_id = 37
        oc.rut_centro = f["rut_centro"]
        oc.name_center = f["nombre_centro"]
        oc.id_centro  = f["id_centro"]
        oc.save
      end  

      oc = OwnerCenter.where(user_id:38, id_centro: f["id_centro"]).first
      unless oc.present?
        oc = OwnerCenter.new
        oc.user_id = 38
        oc.rut_centro = f["rut_centro"]
        oc.name_center = f["nombre_centro"]
        oc.id_centro  = f["id_centro"]
        oc.save
      end  

    end  

    render :json=> {status: "OK"} , :status => :ok
  end

  def create_new_owner
    sql = "SELECT * FROM centros_prop where email<>'' AND status='OK'" 
    array = ActiveRecord::Base.connection.execute(sql).to_a

    array.each do |owner|
      user = User.where(email: owner["email"]).first
      unless user.present?
        u = User.new
        u.email = owner["email"]
        u.password = 'gnatural'
        u.save
      end

      owner_center = OwnerCenter.where(user_id: user.id, center_id: owner["id_centro"]).first
      unless owner_center.present?
        sql = "SELECT * FROM centros WHERE id_centro = #{owner["id_centro"]}"
        array = ActiveRecord::Base.connection.execute(sql).to_a
        center = array.first

        if center.present?
          oc = OwnerCenter.new
          oc.user_id = user.id
          oc.rut_centro = center["rut_centro"]
          oc.name_center = center["nombre_centro"]
          oc.id_centro  = center["id_centro"]
          oc.save
        end  
      end

    end

  end
end  