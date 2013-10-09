require 'spec_helper'

describe GroupMembership do
  it { should belong_to :group }
  it { should belong_to :user }
end
