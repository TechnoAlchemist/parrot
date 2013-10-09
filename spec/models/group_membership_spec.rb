require 'spec_helper'

describe GroupMembership do
  it { should belong_to :group }
  it { should belong_to :user }

  it { should have_valid(:group).when(Group.new) }
  it { should_not have_valid(:group).when(nil) }

  it { should have_valid(:user).when(User.new) }
  it { should_not have_valid(:user).when(nil) }
end
