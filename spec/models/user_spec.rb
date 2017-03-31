require 'rails_helper'

#RSpec.describe User, type: :model do
#  pending "add some examples to (or delete) #{__FILE__}"
#end

# Test suite for the Todo model
RSpec.describe User, type: :model do
  # Association test
  # Validation tests
  # ensure columns title and created_by are present before saving
  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:name) }
end