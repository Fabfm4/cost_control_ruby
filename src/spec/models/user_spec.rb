require_relative '../rails_helper'

RSpec.describe User, type: :model do

  let(:user) { build(:user) }
  let(:user_created) { create(:user) }

  describe "Validations" do
    it "is a client user valid data" do
      user.user_role = "CLIENT"
      expect(user).to be_valid  
      expect(user.user_role.upcase).to eq("CLIENT")
    end
    it "is a admin user valid data" do
      user.user_role = "ADMIN"
      expect(user).to be_valid  
      expect(user.user_role.upcase).to eq("ADMIN")
    end

    it 'is fail when user doesnt have email' do
      user.email = nil
      expect(user).to_not be_valid
    end
    
  end
  
end