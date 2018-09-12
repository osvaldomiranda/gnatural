class Kinesiologist < ActiveRecord::Base

  scope :with_center, -> with_center { where(id_centro: with_center) if with_center.present?}
end
