#!/bin/bash
bundle exec puma -C config/puma.rb &
bundle bundle exec sidekiq -C config/sidekiq.yml &

wait
