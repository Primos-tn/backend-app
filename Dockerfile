
# Seed system
RUN rake db:seed
# Configure all
RUN rake configure:all
#
CMD rails s & sidekiq -c config/sidekiq.yml