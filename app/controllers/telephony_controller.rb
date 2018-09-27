class TelephonyController < ApplicationController
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

    sql = "SELECT * FROM telefonia t, tef_centro c WHERE t.id_tef = c.id_tef AND c.id_centro = #{@id_centro} AND status= 'ANSWERED' ORDER BY t.fecha_llamada"
    @answered_calls =  ActiveRecord::Base.connection.execute(sql).to_a

    sql = "SELECT * FROM telefonia t, tef_centro c WHERE t.id_tef = c.id_tef AND c.id_centro = #{@id_centro} AND status= 'NO ANSWER' ORDER BY t.fecha_llamada"
    @unanswered_calls =  ActiveRecord::Base.connection.execute(sql).to_a


    sql = "SELECT to_char(date_trunc('day', CAST(t.fecha_llamada AS DATE)), 'YYYY-MM-DD') AS date , sum(t.duracion) FROM telefonia t, tef_centro c WHERE t.id_tef = c.id_tef AND c.id_centro = #{@id_centro} AND status= 'ANSWERED' GROUP BY date ORDER BY date "
    answered_calls_chart = ActiveRecord::Base.connection.execute(sql).to_a 
    @answered_calls_chart = answered_calls_chart.map{|a| {a["date"]=>a["sum"]}}
    @answered_calls_chart = @answered_calls_chart.reduce({}, :merge)

    sql = "SELECT to_char(date_trunc('day', CAST(t.fecha_llamada AS DATE)), 'YYYY-MM-DD') AS date , count(*) FROM telefonia t, tef_centro c WHERE t.id_tef = c.id_tef AND c.id_centro = #{@id_centro} AND status= 'NO ANSWER' GROUP BY date ORDER BY date "
    unanswered_calls_chart = ActiveRecord::Base.connection.execute(sql).to_a 
    @unanswered_calls_chart = unanswered_calls_chart.map{|a| {a["date"]=>a["count"]}}
    @unanswered_calls_chart = @unanswered_calls_chart.reduce({}, :merge)

  end
end
