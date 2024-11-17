#!/bin/bash
bundle exec puma -C config/puma.rb &
bundle exec rails solid_queue:start &

wait
