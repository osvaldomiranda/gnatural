class AdminController < ApplicationController
  def index
    @mes = params[:mes] || '08-2018'
  end

  def vta_origen_toxls
    @mes = params[:mes] 

    vta_origen_anual2 = " SELECT upper(login) AS vta_origen,  CAST(create_date_order AS DATE) AS date , id_centro, nombre_centro, date_order, order_id, pos_reference, order_line_note, price_subtotal_incl FROM tablon2_anual WHERE login<>'cupones' AND login<>'cupon'  AND to_char(CAST(create_date_order AS DATE), 'MM-YYYY') = '#{@mes}'  ORDER BY id_centro, vta_origen, date_order"
    @array_vta_origen_xls = ActiveRecord::Base.connection.execute(vta_origen_anual2).to_a   

    respond_to do |format|
      format.xls 
    end
  end
end
