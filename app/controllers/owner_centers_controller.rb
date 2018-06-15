class OwnerCentersController < ApplicationController
  before_action :set_owner_center, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @owner_centers = OwnerCenter.all
    respond_with(@owner_centers)
  end

  def show
    respond_with(@owner_center)
  end

  def new
    @owner_center = OwnerCenter.new
    respond_with(@owner_center)
  end

  def edit
  end

  def create
    @owner_center = OwnerCenter.new(owner_center_params)
    @owner_center.save
    respond_with(@owner_center)
  end

  def update
    @owner_center.update(owner_center_params)
    respond_with(@owner_center)
  end

  def destroy
    @owner_center.destroy
    respond_with(@owner_center)
  end

  private
    def set_owner_center
      @owner_center = OwnerCenter.find(params[:id])
    end

    def owner_center_params
      params.require(:owner_center).permit(:user_id, :rut_centro)
    end
end
