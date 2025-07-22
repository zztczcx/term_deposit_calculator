#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'lib/cli'

Dry::CLI.new(CLI::Commands).call
