# encoding: utf-8
# copyright: 2018, The Authors

title 'Application Validation'

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
  it { should have_port_enabled_in_zone('8080/tcp', 'public') }
end

# Check packages
packages = ['nss-mdns','net-tools','telnet','tcpdump','lsof','strace','wget','mlocate','setroubleshoot','setroubleshoot-server','policycoreutils-devel']

packages.each do |item|
  describe package(item) do
    it { should be_installed }
  end
end

# Check docker application image
describe docker_image('docker.io/fabiogoma/app:latest') do
  it { should exist }
  its('id') { should eq 'sha256:06daf39eff2b030abf18476072bf99d3c748ebf530951f9aedf9e9f2b8477ab4' }
  its('repo') { should eq 'docker.io/fabiogoma/app' }
  its('tag') { should eq 'latest' }
end

# Check running instance of application container
describe docker_container('demo') do
  it { should exist }
  it { should be_running }
  its('image') { should eq 'docker.io/fabiogoma/app:latest' }
  its('repo') { should eq 'docker.io/fabiogoma/app' }
  its('tag') { should eq 'latest' }
  its('ports') { sshould eq '0.0.0.0:8080->8080/tcp' }
  its('command') { should eq 'flask run --host=0.0.0.0 --port=8080' }
end
