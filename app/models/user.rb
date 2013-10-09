class User < ActiveRecord::Base
  belongs_to :cohort, inverse_of: :users
  has_many :group_memberships, inverse_of: :user, dependent: :destroy
  has_many :groups, through: :group_memberships

  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :username
  validates_presence_of :role

  validates_inclusion_of :role, in: %w(student admin)

  # Email validation will change with devise
  validates_presence_of :email
  validates_format_of :email, with: /\A[\w.-]+@[\w.-]+\.[\w]{2,4}\z/
end
