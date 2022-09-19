require 'spec_helper_acceptance'

describe 'dnsclient class:' do
  context 'with default values for class parameters' do
    it 'runs successfully' do
      # The GitHub Actions system does not let you overwrite /etc/resolv.conf
      # and will fail. We work around this by setting the path below.
      pp = <<-EOS
      class { 'dnsclient':
        resolver_config_file => '/tmp/resolv.conf',
      }
      EOS

      apply_manifest(pp, catch_failures: true)
      apply_manifest(pp, catch_changes: true)
    end
  end
end
