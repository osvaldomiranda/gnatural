class TelephonyController < ApplicationController
  def index
     @id_centro = params[:center] 

    if @id_centro.present?
      center = OwnerCenter.where(id_centro: @id_centro).first
      @nombre_centro = center.name_center
      @rut_centro = center.rut_centro 
    else 
      owner_center = current_user.owner_centers.order(:name_center).first
      @id_centro = owner_center.id_centro 
      @rut_centro = owner_center.rut_centro 
      @nombre_centro = owner_center.name_center 
    end 

    sql = "SELECT * FROM telefonia t, tef_centro c WHERE t.id_tef = c.id_tef AND c.id_centro = #{@id_centro} AND status= 'ANSWERED'"
    @answered_calls =  ActiveRecord::Base.connection.execute(sql).to_a

    sql = "SELECT * FROM telefonia t, tef_centro c WHERE t.id_tef = c.id_tef AND c.id_centro = #{@id_centro} AND status= 'NO ANSWER'"
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
