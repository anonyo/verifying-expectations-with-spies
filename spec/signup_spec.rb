require "spec_helper"
require "signup"

describe Signup do
  let(:account) { double("account") }
  let(:user) { double("user") }
  describe "#save" do
    it "creates an account with one user" do
      stub_user_and_account
      signup = Signup.new(email: "user@example.com", account_name: "Example")
      result = signup.save

      expect(Account).to have_received(:create!).with(name: 'Example')
      expect(User).to have_received(:create!).with(account: account, email: 'user@example.com')
      expect(result).to be true
    end
  end

  describe "#user" do
    it "returns the user created by #save" do
      stub_user_and_account
      signup = Signup.new(email: "user@example.com", account_name: "Example")
      signup.save

      result = signup.user

      expect(result).to eq user
    end
  end
  private
  def stub_user_and_account
    allow(Account).to receive(:create!).and_return account
    allow(User).to receive(:create!).and_return user
  end
end
