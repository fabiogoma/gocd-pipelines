# encoding: utf-8
# copyright: 2018, The Authors

title 'NGINX Validation'

# Check SELinux
describe command('getenforce') do
   its('stdout') { should match 'Enforcing' }
end

# Check Firewall
describe firewalld do
  it { should be_running }
  its('default_zone') { should eq 'public' }
  it { should have_service_enabled_in_zone('ssh', 'public') }
  it { should have_service_enabled_in_zone('mdns', 'public') }
  it { should have_service_enabled_in_zone('http', 'public') }
  it { should have_service_enabled_in_zone('https', 'public') }
end

# Check packages
packages = ['nss-mdns','net-tools','telnet','tcpdump','lsof','strace','wget','mlocate','setroubleshoot','setroubleshoot-server','policycoreutils-devel']

packages.each do |item|
  describe package(item) do
    it { should be_installed }
  end
end

# Check NGINX version and SSL module
describe nginx do
  its('version') { should cmp >= '1.14.0' }
  its('modules') { should include 'http_ssl' }
end

# Check NGINX Ports for HTTP and HTTPS
ports = [80,443]

ports.each do |item|
  describe port(item) do
    it { should be_listening }
    its('processes') {should include 'nginx'}
    its('protocols') { should cmp 'tcp' }
    its('addresses') {should include '0.0.0.0'}
  end
end
