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

        oc = OwnerCenter.new
        oc.user_id = 37
        oc.rut_centro = f["rut_centro"]
        oc.name_center = f["nombre_centro"]
        oc.id_centro  = f["id_centro"]
        oc.save

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
end  