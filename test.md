## Notices
  Please verify tables names & associations when running test
  Some table name will broke the tests 


## This will destroy your db and then create it and then migrate your current schema:

`rake db:drop db:create db:migrate RAILS_ENV=test`

## This will reset your database and reload your current schema with all:

`rake db:reset db:migrate RAILS_ENV=tes`


## Schema migration 

`rake db:migrate RAILS_ENV=test`

## run a single file 

`rake test TEST=test/jobs/business_alerts_job_test.rb`

`rake test TEST=test/controllers/admin/accounts_registrations_invitations_controller_test.rb`

## Run a specific folder

`rake test TEST=test/controllers/dashboard/*.rb`
