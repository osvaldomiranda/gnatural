class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :owner_centers
  has_secure_token :access_token

  MES      = ['09-2017', '10-2017','11-2017','12-2017','01-2018','02-2018','03-2018','04-2018','05-2018','06-2018','07-2018','08-2018']
  def self.mes_options_for_select
    #GENDERS.to_enum.with_index(0).to_a
    MES.each.map { |t| [t, t.upcase.gsub(' ', '_')] }
  end 
end
