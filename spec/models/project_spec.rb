require 'spec_helper'

describe Project do
  it { should belong_to :cohort }
  it { should have_many(:groups).dependent(:destroy) }

  it { should have_valid(:title).when('Blackjack') }
  it { should_not have_valid(:title).when('', nil) }

  it { should have_valid(:link).when('apollo.launchacademy.com') }
  it { should_not have_valid(:link).when('', nil) }

  it { should have_valid(:cohort).when(Cohort.new) }
  it { should_not have_valid(:cohort).when(nil) }
end
