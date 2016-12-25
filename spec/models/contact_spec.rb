require 'spec_helper'

describe Contact do
  before do
  @contact = Contact.new(name: "Example User", email: "user@example.com")
  end

  subject { @contact }
  it { should respond to(:name) }
  it { should respond to(:email) }
  it { should be valid }
  describe "when name is not present" do
    before { @contact.name = " " }
    it { should not be valid }
  end
end
