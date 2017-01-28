#!/bin/bash
export RAILS_ENV=staging
# rails s
rake configure:all

rake gallery:set_dominant_colors
