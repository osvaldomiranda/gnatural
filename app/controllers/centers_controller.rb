class CentersController < ApplicationController
  before_action :set_center, only: [:owners, :show, :edit, :update, :destroy]
  respond_to :html

  def index
    @centers = Center.order(:nombre_centro)
  end

  def show
    respond_with(@center)
  end

  def new
    @center = Center.new
    respond_with(@center)
  end

  def edit
  end

  def create
    @center = Center.new(center_params)
    @center.save
    respond_with(@center)
  end

  def update
    @center.update(center_params)
    respond_with(@center)
  end

  def destroy
    @centers = Center.order(:nombre_centro)
    @center.destroy
    render 'index'
  end

  def owners
    owners_prop  = OwnerProp.where(id_centro: @center.id_centro)
    @owners = Owner.where(id_propietario: owners_prop.map{|o| o.id_propietario})
  end

  def newowner
    begin
      owner = Owner.where(id_propietario: params[:ownersprop][:id_propietario]).first 
      ownerprop = OwnerProp.new
      
      ownerprop.id_propietario = params[:ownersprop][:id_propietario]
      ownerprop.id_centro = params[:ownersprop][:id_centro]
      ownerprop.email = owner.email
      ownerprop.status = 'OK'
      ownerprop.save
    rescue
    end  

    owners_prop  = OwnerProp.where(id_centro: params[:ownersprop][:id_centro])
    @owners = Owner.where(id_propietario: owners_prop.map{|o| o.id_propietario})
    @center = Center.where(id_centro: params[:ownersprop][:id_centro]).first

    render 'owners'
  end

  private
    def set_center
      if params[:id].present?
        @center = Center.where(id_centro: params[:id]).first
      else  
        @center = Center.where(id_centro: params[:id_centro]).first
      end  
    end


    def center_params
      params.require(:center).permit(:id_centro, :nombre_centro, :dir_centro, :sector_centro , :comuna_centro , :rut_centro , :web , :email, :telefonos, :anexo , :plan, :status)
    end
end
