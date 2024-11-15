#!/bin/bash
bundle exec puma -C config/puma.rb &
pkill sidekiq &
bundle exec sidekiq -C config/sidekiq.yml &

wait
