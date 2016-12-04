class SystemConfiguration < ActiveRecord::Base
  def with_invitation?
    self.with_invitation
  end
end
