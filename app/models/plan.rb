class Plan < ActiveRecord::Base

  def self.for_select()
    Plan.all.order(:name).map{|t| [t.name, t.name]}
  end 
end
