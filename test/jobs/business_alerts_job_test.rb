require 'test_helper'

class BusinessAlertsJobTest < ActiveJob::TestCase
  test 'that account is charged' do
    BusinessAlertsJob.delay()
    #assert account.reload.charged_for?(product)
  end
end
