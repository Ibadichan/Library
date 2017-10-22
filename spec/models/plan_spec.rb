require 'rails_helper'

RSpec.describe Plan, type: :model do
  it { should validate_presence_of(:title) }
  it { should belong_to(:user) }

  it { should have_many(:plans_books).dependent(:destroy) }
  it { should have_many(:books).through(:plans_books) }
end
