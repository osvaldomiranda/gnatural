class OwnersController < ApplicationController
 before_action :set_owner, only: [:show, :edit, :update, :destroy]
  respond_to :html

  def index
    @owners = Owner.order(:nombre_propietario)
  end

  def show
    respond_with(@owner)
  end

  def new
    @owner = Owner.new
    respond_with(@owner)
  end

  def edit
  end

  def create
    @owner = Owner.new(owner_params)
    @owner.save
    respond_with(@owner)
  end

  def update
    @owner.update(owner_params)
    respond_with(@owner)
  end

  def destroy
    @owners = Owner.order(:nombre_propietario)
    @owner.destroy
    render 'index'
  end

  private
    def set_owner
      if params[:id].present?
        @owner = Owner.where(id_propietario: params[:id]).first
      else  
        @owner = Owner.where(id_propietario: params[:id_propietario]).first
      end  
    end


    def owner_params
      params.require(:owner).permit(:id_propietario, :nombre_propietario, :rut_propietario, :dir_propietario, :email)
    end

    
end
