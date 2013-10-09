class Project < ActiveRecord::Base
  belongs_to :cohort, inverse_of: :projects
  has_many :groups, inverse_of: :project, dependent: :destroy

  validates_presence_of :title
  validates_presence_of :link
end
