class OwnerCenter < ActiveRecord::Base
  belongs_to :user


  def self.for_select(user_id)
    OwnerCenter.where(user_id: user_id).map{|t| [t.name_center, t.rut_centro]}
  end 

end
