lib = File.expand_path("../", __FILE__)
$:.unshift(lib)

require 'spec_helper'
require 'Nginx/Configuration.rb'

config = Nginx::Configuration.new(property)

context 'nginx - base configuration' do
    context 'package dependencies' do
        describe package('nginx') do
            it { should be_installed.with_version(config.version()) }
        end
    end

    context 'service configuration' do
        describe service('nginx') do
            it { should be_enabled }
            it { should be_running }

            if os[:family] == 'windows'
                it { should have_start_mode('automatic') }
            end
        end

        describe user("#{config.user()}") do
            it { should exist }
            it { should belong_to_primary_group "#{config.group()}" }
            it { should have_login_shell '' }
            it { should have_home_directory '' }
        end

        describe group("#{config.group()}") do
            it { should exist }
        end
    end

    context 'directory structure' do
        describe file("#{config.install_dir()}") do
            it { should be_directory }
            it { should be_mode 755 }
            it { should be_owned_by 'root' }
            it { should be_grouped_into 'root' }
        end
        describe file("#{config.install_dir()}/nginx.conf") do
            it { should be_file }
            it { should be_mode 644 }
            it { should be_owned_by 'root' }
            it { should be_grouped_into 'root' }
        end

        describe file('/etc/nginx/conf.d') do
            it { should be_directory }
            it { should be_mode 755 }
            it { should be_owned_by 'root' }
            it { should be_grouped_into 'root' }
        end
    end

    context 'configuration' do
        describe file("#{config.install_dir()}/nginx.conf") do
            its(:content) { should contain "user #{config.user()};" }
            its(:content) { should contain "error_log #{config.log_dir()}/error.log" }
            its(:content) { should contain "access_log  #{config.log_dir()}/access.log" }
            its(:content) { should contain "log_format main \'#{config.log_format()}\'" }
            its(:content) { should contain "include #{config.install_dir()}/conf.d/\*.conf;" }
            its(:content) { should_not contain 'server \{' }
        end
    end
end