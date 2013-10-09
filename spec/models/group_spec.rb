require 'spec_helper'

describe Group do
  it { should belong_to :project }
  it { should have_many(:group_memberships).dependent(:destroy) }
  it { should have_many(:users).through(:group_memberships) }

  it { should have_valid(:project).when(Project.new) }
  it { should_not have_valid(:project).when(nil) }
end
