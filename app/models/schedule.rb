class Schedule < ActiveRecord::Base
  self.table_name = "agenda"
  self.primary_key = "reservation_id"

  def self.reservado(id_centro, tipo, fecha)
  	Schedule.where(id_centro: id_centro).where(name: tipo).where(start_time: fecha.beginning_of_day..fecha.end_of_day).count > 0
  end

  def self.reservado_hora(id_centro, tipo, fechahora)
  	Schedule.where(id_centro: id_centro).where(name: tipo).where(start_time: fechahora).count > 0
  end

end