require 'json'
require 'puppetlabs_spec_helper/rake_tasks'
require 'puppet-lint/tasks/puppet-lint'
require 'puppet_blacksmith/rake_tasks' if Bundler.rubygems.find_name('puppet-blacksmith').any?
require 'github_changelog_generator/task' if Bundler.rubygems.find_name('github_changelog_generator').any?
# Puppet Strings (Documentation generation from inline comments)
# See: https://github.com/puppetlabs/puppet-strings#rake-tasks
require 'puppet-strings/tasks' if Bundler.rubygems.find_name('puppet-strings').any?

exclude_paths = [
  "pkg/**/*",
  "vendor/**/*",
  "spec/**/*",
]

PuppetLint.configuration.send("disable_80chars")
PuppetLint.configuration.send("disable_140chars")
PuppetLint.configuration.ignore_paths = exclude_paths
PuppetLint.configuration.relative = true

desc 'Validate manifests, templates, ruby files and shell scripts'
task :validate do
  Dir['spec/**/*.rb'].each do |ruby_file|
    sh "ruby -c #{ruby_file}" unless ruby_file =~ /spec\/fixtures/
  end
end

desc 'Alias for strings:generate'
task :doc => ['strings:generate']

desc 'Generate REFERENCE.md'
task :reference => ['strings:generate:reference']

def future_release
  return unless (Rake.application.top_level_tasks.include?("changelog") || Rake.application.top_level_tasks.include?("release"))
  returnVal = "v%s" % JSON.load(File.read('metadata.json'))['version']
  raise "unable to find the future_release (version) in metadata.json" if returnVal.nil?
  puts "future_release:#{returnVal}"
  returnVal
end

if Bundler.rubygems.find_name('github_changelog_generator').any?
  GitHubChangelogGenerator::RakeTask.new :changelog do |config|
    raise "Set CHANGELOG_GITHUB_TOKEN environment variable eg 'export CHANGELOG_GITHUB_TOKEN=valid_token_here'" if Rake.application.top_level_tasks.include? "changelog" and ENV['CHANGELOG_GITHUB_TOKEN'].nil?
    config.user = 'ghoneycutt'
    config.project = 'puppet-module-dnsclient'
    config.since_tag = 'v3.6.0'
    config.future_release = "#{future_release}"
    config.issues = false
    config.max_issues = 100
#    config.exclude_labels = ["label 1","label 2"]
    config.add_pr_wo_labels = true
    config.merge_prefix = "### Merged Pull Requests"
    config.configure_sections = {
      "Changed" => {
        "prefix" => "### Changed",
        "labels" => ["breaking-change"],
      },
      "Added" => {
        "prefix" => "### Added",
        "labels" => ["feature", "enhancement"],
      },
      "Fixed" => {
        "prefix" => "### Fixed",
        "labels" => ["bugfix","bug"],
      },
    }
  end
end

namespace :release do
  desc "Release commit"
  task :commit do
    sh "git add CHANGELOG.md"
    sh "git add REFERENCE.md"
    sh "git add metadata.json"
    sh "git commit -m 'Release #{future_release}'"
  end
end

desc "Release new module version"
task :release => [:changelog, :reference, "release:commit"]
