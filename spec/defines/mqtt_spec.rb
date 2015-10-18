require 'spec_helper'

describe 'mqtt', :type => :puppet_function do
  let(:facts) {{ :is_virtual => 'false' }}

  [
    'Debian',
    'RedHat',
    'Fedora',
    'Suse',
    'FreeBSD',
    'Archlinux',
    'Gentoo',
    'Gentoo (Facter < 1.7)'
  ].each do |system|
    context "when on system #{system}" do
      if system == 'Gentoo (Facter < 1.7)'
        let :facts do
          super().merge({ :osfamily => 'Linux', :operatingsystem => 'Gentoo' })
        end
      elsif system == 'Suse'
        let :facts do
          super().merge({ :osfamily => system,:operatingsystem => 'SLES',:operatingsystemmajrelease => '11' })
        end
      elsif system == 'Fedora'
        let :facts do
          super().merge({ :osfamily => 'RedHat', :operatingsystem => system ,:operatingsystemmajrelease => '22' })
        end
      else
        let :facts do
          super().merge({ :osfamily => system })
        end
      end

      it { should contain_class('mqtt::install') }
      it { should contain_class('mqtt::config') }
      it { should contain_class('mqtt::service') }


    end
  end
end
