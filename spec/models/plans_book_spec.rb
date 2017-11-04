require 'rails_helper'

RSpec.describe PlansBook, type: :model do
  it { should belong_to(:plan) }
  it { should belong_to(:book) }
  it { should have_many(:subscriptions).dependent(:destroy) }
end
