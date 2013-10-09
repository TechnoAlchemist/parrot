class Group < ActiveRecord::Base
  belongs_to :project, inverse_of: :groups
  has_many :group_memberships, inverse_of: :group, dependent: :destroy
  has_many :users, through: :group_memberships

  validates_presence_of :project
end
