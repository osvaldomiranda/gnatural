class Owner < ActiveRecord::Base
  self.table_name = "propietario"
  self.primary_key = "id_propietario"

  before_create :set_account_number
  

  validates :rut_propietario, presence: true, rutFormat: true

  def self.for_select
  	Owner.all.order(nombre_propietario: :asc).map {|t| [t.email, t.id_propietario]}
  end

  def email
    owner = OwnerProp.where(id_propietario: self.id_propietario).first
    if owner.present?
      return owner.email
    else
      return nil
    end  
  end

  def self.permit
    sql = "SELECT * FROM hora_act"
    array =  ActiveRecord::Base.connection.execute(sql).to_a
    if DateTime.parse(array.last["hora"]) < 2.day.a 
      false
    else
      true
    end    
  end  

  def set_account_number
    last_account_number = Owner.maximum(:id_propietario)
    self.id_propietario = last_account_number.to_i + 1
  end
end