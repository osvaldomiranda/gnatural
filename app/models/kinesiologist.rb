class Kinesiologist < ActiveRecord::Base

  before_validation { self.hh_mensuales = 1 if !self.hh_mensuales.present?  }
  before_validation { self.hh_mensuales = 1 if self.hh_mensuales < 1  }
  scope :with_center, -> with_center { where(id_centro: with_center) if with_center.present?}
end
