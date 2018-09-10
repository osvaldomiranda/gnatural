# encoding: utf-8
class Api::V1::PlanyoController < ApplicationController
  protect_from_forgery
  # respond_to :json

  def agenda
    require 'rest-client'

    headers['Access-Control-Allow-Origin'] = "*"


    # Revisar parametros
    apiKey = params[:apikey] 
    fechaDesde = params[:start_time] 
    fechaHasta = params[:end_time] 


    if apiKey.present? && fechaDesde.present? && fechaHasta.present?
      # Pegarle a Planyo
    url = "https://www.planyo.com/rest/?method=list_reservations&api_key=#{apiKey}&start_time=#{fechaDesde}&end_time=#{fechaHasta}"      
      
    response = RestClient.get url

      # Extraer objeto
      array = JSON.parse(response.body)

      # responder con objeto
      render :json=> array["data"]["results"] , :status => :ok
    else
      render :json=> {message: 'parametros incorrectos, apikey, start_time, end_time'} , :status => :ok 
    end


  end  

  def options
    headers['Access-Control-Allow-Origin'] = request.env['HTTP_ORIGIN']
    headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
    headers['Access-Control-Max-Age'] = '1000'
    headers['Access-Control-Allow-Headers'] = '*,x-requested-with'
    head :ok
  end
end  