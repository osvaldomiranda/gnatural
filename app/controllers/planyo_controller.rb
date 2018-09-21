class PlanyoController < ApplicationController
  def index
    @id_centro = params[:center] 

    if @id_centro.present?
      center = Center.where(id_centro: @id_centro).first
    else 
      if current_user.role?('admin')
        center = Center.order(:nombre_centro).first
      else
        owner_center = OwnerProp.where(email: current_user.email).first
        center = Center.where(id_centro: owner_center.id_centro).order(:nombre_centro).first
      end
    end 

    @id_centro = center.id_centro 
    @rut_centro = center.rut_centro 
    @nombre_centro = center.nombre_centro 
  
    date = params[:date]
    if date.present?
      @date = Date.parse(date)
    else
      @date = Date.today
    end    

    @tipos = Schedule.select(:name).uniq

    @tipo = params[:tipo] || nil
    datetime = params[:datetime] || nil

    if @tipo.present?
      @schedule = Schedule.where(id_centro: @id_centro).where(name: @tipo).where(start_time: datetime).first
    else
      @schedule = nil
    end    

  end
end
