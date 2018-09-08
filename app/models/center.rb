class Center < ActiveRecord::Base
  self.table_name = "centros"
  before_create :set_id_centro
  
  def set_id_centro
    last_id_centro = Center.maximum(:id_centro)
    self.id_centro = last_id_centro.to_i + 1
  end


end