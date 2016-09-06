require 'simplecov'
require 'codeclimate-test-reporter'

SimpleCov.formatters = [
  SimpleCov::Formatter::HTMLFormatter,
  CodeClimate::TestReporter::Formatter
]

SimpleCov.start do
  add_filter '/spec/'
  # Exclude bundled Gems in `/.vendor/`
  add_filter '/.vendor/'
end

require 'puppetlabs_spec_helper/module_spec_helper'
