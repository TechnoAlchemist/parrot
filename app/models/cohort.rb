class Cohort < ActiveRecord::Base
  has_many :users, inverse_of: :cohort
  has_many :projects, inverse_of: :cohort, dependent: :destroy

  validates_presence_of :term
end
