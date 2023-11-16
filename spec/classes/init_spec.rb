require 'spec_helper'
describe 'dnsclient' do
  on_supported_os.each do |os, os_facts|
    context "on #{os} with default values for class parameters" do
      let(:facts) { os_facts }

      it { is_expected.to compile.with_all_deps }

      it { is_expected.to contain_class('dnsclient') }

      it {
        is_expected.to contain_file('dnsclient_resolver_config_file').with({
          'ensure' => 'file',
          'path'   => '/etc/resolv.conf',
          'owner'  => 'root',
          'group'  => 'root',
          'mode'   => '0644',
          'backup' => nil,
        })
      }

      content = <<-END.gsub(%r{^\s+\|}, '')
        |# This file is being maintained by Puppet.
        |# DO NOT EDIT
        |options rotate timeout:1
        |nameserver 8.8.8.8
        |nameserver 8.8.4.4
      END

      it {
        is_expected.to contain_file('dnsclient_resolver_config_file').with_content(content)
      }
    end
  end

  context 'with parameter nameservers set' do
    let :params do
      { nameservers: ['4.2.2.2', '4.2.2.1'] }
    end

    content = <<-END.gsub(%r{^\s+\|}, '')
      |# This file is being maintained by Puppet.
      |# DO NOT EDIT
      |options rotate timeout:1
      |nameserver 4.2.2.2
      |nameserver 4.2.2.1
    END

    it {
      is_expected.to contain_file('dnsclient_resolver_config_file').with_content(content)
    }
  end

  context 'with parameter nameservers set to a single nameserver as an array' do
    let :params do
      { nameservers: ['4.2.2.2'] }
    end

    content = <<-END.gsub(%r{^\s+\|}, '')
      |# This file is being maintained by Puppet.
      |# DO NOT EDIT
      |options rotate timeout:1
      |nameserver 4.2.2.2
    END

    it {
      is_expected.to contain_file('dnsclient_resolver_config_file').with_content(content)
    }
  end

  context 'with no options' do
    let :params do
      { 'options' => [] }
    end

    content = <<-END.gsub(%r{^\s+\|}, '')
      |# This file is being maintained by Puppet.
      |# DO NOT EDIT
      |nameserver 8.8.8.8
      |nameserver 8.8.4.4
    END

    it {
      is_expected.to contain_file('dnsclient_resolver_config_file').with_content(content)
    }
  end

  context 'with options set to a single value as an array' do
    let :params do
      { options: ['ndots:2'] }
    end

    content = <<-END.gsub(%r{^\s+\|}, '')
      |# This file is being maintained by Puppet.
      |# DO NOT EDIT
      |options ndots:2
      |nameserver 8.8.8.8
      |nameserver 8.8.4.4
    END

    it {
      is_expected.to contain_file('dnsclient_resolver_config_file').with_content(content)
    }
  end

  context 'with options set to multiple values' do
    let :params do
      { options: ['ndots:2', 'rotate'] }
    end

    content = <<-END.gsub(%r{^\s+\|}, '')
      |# This file is being maintained by Puppet.
      |# DO NOT EDIT
      |options ndots:2 rotate
      |nameserver 8.8.8.8
      |nameserver 8.8.4.4
    END

    it {
      is_expected.to contain_file('dnsclient_resolver_config_file').with_content(content)
    }
  end

  context 'with search set to multiple values' do
    let :params do
      { search: ['foo.example.tld', 'example.tld'] }
    end

    content = <<-END.gsub(%r{^\s+\|}, '')
      |# This file is being maintained by Puppet.
      |# DO NOT EDIT
      |search foo.example.tld example.tld
      |options rotate timeout:1
      |nameserver 8.8.8.8
      |nameserver 8.8.4.4
    END

    it {
      is_expected.to contain_file('dnsclient_resolver_config_file').with_content(content)
    }
  end

  context 'with search set to a single value as an array' do
    let :params do
      { search: ['example.tld'] }
    end

    content = <<-END.gsub(%r{^\s+\|}, '')
      |# This file is being maintained by Puppet.
      |# DO NOT EDIT
      |search example.tld
      |options rotate timeout:1
      |nameserver 8.8.8.8
      |nameserver 8.8.4.4
    END

    it {
      is_expected.to contain_file('dnsclient_resolver_config_file').with_content(content)
    }
  end

  context 'with search and domain set' do
    let :params do
      {
        search: ['foo.example.tld', 'example.tld'],
        domain: 'valid.tld',
      }
    end

    it 'fails' do
      expect do
        is_expected.to raise_error(Puppet::Error, %r{search and domain are mutually exclusive and both have been defined})
      end
    end
  end

  context 'with domain set' do
    let :params do
      { domain: 'valid.tld' }
    end

    content = <<-END.gsub(%r{^\s+\|}, '')
      |# This file is being maintained by Puppet.
      |# DO NOT EDIT
      |domain valid.tld
      |options rotate timeout:1
      |nameserver 8.8.8.8
      |nameserver 8.8.4.4
    END

    it {
      is_expected.to contain_file('dnsclient_resolver_config_file').with_content(content)
    }
  end

  context 'with domain and no options set' do
    let :params do
      {
        domain: 'valid.tld',
        options: [],
      }
    end

    content = <<-END.gsub(%r{^\s+\|}, '')
      |# This file is being maintained by Puppet.
      |# DO NOT EDIT
      |domain valid.tld
      |nameserver 8.8.8.8
      |nameserver 8.8.4.4
    END

    it {
      is_expected.to contain_file('dnsclient_resolver_config_file').with_content(content)
    }
  end

  context 'with search set to an invalid single value' do
    let :params do
      { search: ['-notvalid.tld'] }
    end

    it 'fails' do
      expect do
        is_expected.to raise_error(Puppet::Error, %r{search parameter does not match regex.})
      end
    end
  end

  context 'with search set to an invalid value in an array' do
    let :params do
      { search: ['valid.tld', '-notvalid.tld'] }
    end

    it 'fails' do
      expect do
        is_expected.to raise_error(Puppet::Error, %r{search parameter does not match regex.})
      end
    end
  end

  context 'with only search' do
    let :params do
      {
        search: ['valid.tld'],
        options: [],
      }
    end

    content = <<-END.gsub(%r{^\s+\|}, '')
      |# This file is being maintained by Puppet.
      |# DO NOT EDIT
      |search valid.tld
      |nameserver 8.8.8.8
      |nameserver 8.8.4.4
    END

    it {
      is_expected.to contain_file('dnsclient_resolver_config_file').with_content(content)
    }
  end

  context 'with search and sortlist' do
    let :params do
      {
        search: ['valid.tld'],
        sortlist: ['10.10.10.0/24', '10.10.11.0/24'],
        options: [],
      }
    end

    content = <<-END.gsub(%r{^\s+\|}, '')
      |# This file is being maintained by Puppet.
      |# DO NOT EDIT
      |search valid.tld
      |sortlist 10.10.10.0/24 10.10.11.0/24
      |nameserver 8.8.8.8
      |nameserver 8.8.4.4
    END

    it {
      is_expected.to contain_file('dnsclient_resolver_config_file').with_content(content)
    }
  end

  context 'with search, sortlist, and options' do
    let :params do
      {
        search: ['valid.tld'],
        sortlist: ['10.10.10.0/24', '10.10.11.0/24'],
        options: ['rotate'],
      }
    end

    content = <<-END.gsub(%r{^\s+\|}, '')
      |# This file is being maintained by Puppet.
      |# DO NOT EDIT
      |search valid.tld
      |sortlist 10.10.10.0/24 10.10.11.0/24
      |options rotate
      |nameserver 8.8.8.8
      |nameserver 8.8.4.4
    END

    it {
      is_expected.to contain_file('dnsclient_resolver_config_file').with_content(content)
    }
  end

  context 'with sortlist set to an array of values' do
    let :params do
      { sortlist: ['10.10.10.0/24', '10.10.11.0/24'] }
    end

    content = <<-END.gsub(%r{^\s+\|}, '')
      |# This file is being maintained by Puppet.
      |# DO NOT EDIT
      |sortlist 10.10.10.0/24 10.10.11.0/24
      |options rotate timeout:1
      |nameserver 8.8.8.8
      |nameserver 8.8.4.4
    END

    it {
      is_expected.to contain_file('dnsclient_resolver_config_file').with_content(content)
    }
  end

  context 'with sortlist, options, and domain' do
    let :params do
      {
        sortlist: ['10.10.10.0/24', '10.10.11.0/24'],
        domain: 'valid.tld',
      }
    end

    content = <<-END.gsub(%r{^\s+\|}, '')
      |# This file is being maintained by Puppet.
      |# DO NOT EDIT
      |sortlist 10.10.10.0/24 10.10.11.0/24
      |domain valid.tld
      |options rotate timeout:1
      |nameserver 8.8.8.8
      |nameserver 8.8.4.4
    END

    it {
      is_expected.to contain_file('dnsclient_resolver_config_file').with_content(content)
    }
  end

  context 'with sortlist, no options, and domain' do
    let :params do
      {
        sortlist: ['10.10.10.0/24', '10.10.11.0/24'],
        domain: 'valid.tld',
        options: [],
      }
    end

    content = <<-END.gsub(%r{^\s+\|}, '')
      |# This file is being maintained by Puppet.
      |# DO NOT EDIT
      |sortlist 10.10.10.0/24 10.10.11.0/24
      |domain valid.tld
      |nameserver 8.8.8.8
      |nameserver 8.8.4.4
    END

    it {
      is_expected.to contain_file('dnsclient_resolver_config_file').with_content(content)
    }
  end

  context 'with sortlist set to a single value as an array' do
    let :params do
      { sortlist: ['10.10.10.0/24'] }
    end

    content = <<-END.gsub(%r{^\s+\|}, '')
      |# This file is being maintained by Puppet.
      |# DO NOT EDIT
      |sortlist 10.10.10.0/24
      |options rotate timeout:1
      |nameserver 8.8.8.8
      |nameserver 8.8.4.4
    END

    it {
      is_expected.to contain_file('dnsclient_resolver_config_file').with_content(content)
    }
  end

  context 'with parameter resolver_config_file_ensure not set to \'file\' \'present\' or \'absent\'' do
    let :params do
      { resolver_config_file_ensure: 'invalid' }
    end

    it 'fails' do
      expect do
        is_expected.to raise_error(Puppet::Error, %r{Valid values for \$resolver_config_file_ensure are \'absent\', \'file\', or \'present\'. Specified value is invalid})
      end
    end
  end

  context 'with parameter resolver_config_file_ensure set to present' do
    let :params do
      { resolver_config_file_ensure: 'present' }
    end

    it {
      is_expected.to contain_file('dnsclient_resolver_config_file').with({
        'ensure' => 'present',
        'path'   => '/etc/resolv.conf',
        'owner'  => 'root',
        'group'  => 'root',
        'mode'   => '0644',
      })
    }
  end

  context 'with parameter resolver_config_file_ensure set to absent' do
    let :params do
      { resolver_config_file_ensure: 'absent' }
    end

    it {
      is_expected.to contain_file('dnsclient_resolver_config_file').with({
        'ensure' => 'absent',
      })
    }
  end

  context 'with parameter resolver_config_file set' do
    let :params do
      { resolver_config_file: '/tmp/resolv.conf' }
    end

    it {
      is_expected.to contain_file('dnsclient_resolver_config_file').with({
        'path' => '/tmp/resolv.conf',
      })
    }
  end

  context 'with parameter resolver_config_file_owner set' do
    let :params do
      { resolver_config_file_owner: 'foo' }
    end

    it {
      is_expected.to contain_file('dnsclient_resolver_config_file').with({
        'owner' => 'foo',
      })
    }
  end

  context 'with parameter resolver_config_file_group set' do
    let :params do
      { resolver_config_file_group: 'bar' }
    end

    it {
      is_expected.to contain_file('dnsclient_resolver_config_file').with({
        'group' => 'bar',
      })
    }
  end

  context 'with parameter resolver_config_file_mode set' do
    let :params do
      { resolver_config_file_mode: '0777' }
    end

    it {
      is_expected.to contain_file('dnsclient_resolver_config_file').with({
        'mode' => '0777',
      })
    }
  end

  context 'with parameter resolver_config_backup set' do
    let :params do
      { resolver_config_backup: false }
    end

    it { is_expected.to contain_file('dnsclient_resolver_config_file').with_backup(false) }
  end
end
