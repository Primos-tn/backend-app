#!/bin/bash
export RAILS_ENV=staging
rake assets:clobber
rake assets:clean
rake assets:precompile