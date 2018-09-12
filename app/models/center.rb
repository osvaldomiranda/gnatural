class Center < ActiveRecord::Base
  self.table_name = "centros"
  before_create :set_id_centro
  

  validates :rut_centro, presence: true, rutFormat: true

  def set_id_centro
    last_id_centro = Center.maximum(:id_centro)
    self.id_centro = last_id_centro.to_i + 1
  end

  STATUS = ['OK', 'NO OK']
  def self.status_for_select
    STATUS.each.map { |t| [t, t.upcase.gsub(' ', '_')] }
  end 



end