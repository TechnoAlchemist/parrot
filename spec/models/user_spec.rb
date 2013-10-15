require 'spec_helper'

describe User do
  it { should belong_to :cohort }
  it { should have_many(:group_memberships).dependent(:destroy) }
  it { should have_many(:groups).through(:group_memberships) }

  it { should have_valid(:email).when('user@apollo.com') }
  it { should_not have_valid(:email).when('', nil, 'betsy') }

  it { should have_valid(:first_name).when('zeus') }
  it { should_not have_valid(:first_name).when('', nil) }

  it { should have_valid(:last_name).when('pellegrino') }
  it { should_not have_valid(:last_name).when('', nil) }

  it { should have_valid(:username).when('napster123') }
  it { should_not have_valid(:username).when('', nil) }

  it { should have_valid(:role).when('student', 'admin') }
  it { should_not have_valid(:role).when('', nil, 'player') }

  it { should have_valid(:provider).when('github') }
  it { should_not have_valid(:provider).when(nil, '') }

  it { should have_valid(:uid).when('123545') }
  it { should_not have_valid(:uid).when(nil, '') }
end
