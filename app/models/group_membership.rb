class GroupMembership < ActiveRecord::Base
  belongs_to :user, inverse_of: :group_memberships
  belongs_to :group, inverse_of: :group_memberships

  validates_presence_of :group
  validates_presence_of :user
end
