class Owner < ActiveRecord::Base
  self.table_name = "propietario"

  # validates :rut_propietario, presence: true, rutFormat: true

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
end