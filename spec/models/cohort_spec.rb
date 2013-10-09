require 'spec_helper'

describe Cohort do
  it { should have_many :projects }
  it { should have_many :users }

  it { should have_valid(:term).when('Spring 13') }
  it { should_not have_valid(:term).when('', nil) }
end
