class KinesiologistsController < ApplicationController
  before_action :set_kinesiologist, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @id_centro = params[:center] || nil

    if params[:center].present?
      @kinesiologists = Kinesiologist.with_center(@id_centro)
    else
      @kinesiologists = Kinesiologist.all 
    end

    
    respond_with(@kinesiologists)
  end

  def show
    respond_with(@kinesiologist)
  end

  def new
    @kinesiologist = Kinesiologist.new
    respond_with(@kinesiologist)
  end

  def edit
  end

  def create
    @kinesiologist = Kinesiologist.new(kinesiologist_params)
    @kinesiologist.save
    respond_with(@kinesiologist)
  end

  def update
    @kinesiologist.update(kinesiologist_params)
    respond_with(@kinesiologist)
  end

  def destroy
    @kinesiologist.destroy
    respond_with(@kinesiologist)
  end

  private
    def set_kinesiologist
      @kinesiologist = Kinesiologist.find(params[:id])
    end

    def kinesiologist_params
      params.require(:kinesiologist).permit(:id_centro, :nombre, :hh_mensuales)
    end
end
