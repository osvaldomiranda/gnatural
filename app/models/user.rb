class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_secure_token :access_token

   #********************************************************
 #Begin roles
  ROLES = %w[ownercenter admin]

  scope :with_role, -> role { where('roles_mask & ? > 0', 2**ROLES.index(role.to_s)) }
  
  def self.get_roles_mask(roles)
    roles = roles.map{|r| r.to_s}
    (roles & ROLES).map { |r| 2**ROLES.index(r) }.sum
  end

  def roles=(roles)
    roles = roles.map {|r| r.to_s}
    self.roles_mask = (roles & ROLES).map { |r| 2**ROLES.index(r)}.sum
  end

  def roles
    ROLES.reject { |r| ((roles_mask || 0) & 2**ROLES.index(r)).zero? }
  end
  
  def s_roles
    roles.join(', ').humanize
  end

  def role_symbols
    roles.map(&:to_sym)
  end

  def role?(role)
    sql = "SELECT * FROM hora_act"
    array =  ActiveRecord::Base.connection.execute(sql).to_a
    ha = DateTime.parse(array.last["hora"])
    if ha > 1.day.ago 
      roles.include? role.to_s
    else
      false
    end    
  end

  #retorna true si tiene algunos de los relos del arreglo a_roles
  def roles?(a_roles)
    result = false
    a_roles.each{|role|
      result ||= role?(role)
    }
    return result
  end

  def rol
    self.roles_mask
  end

  ## End ROLES 




  def owner_centers
    if self.role?('admin')
      OwnerProp.all
    else  
      OwnerProp.where(email: self.email)
    end  
  end

end
