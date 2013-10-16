#
# Author::  Achim Rosenhagen (<a.rosenhagen@ffuenf.de>)
# Cookbook Name:: vmware-tools
# Recipe:: default
#
# Copyright 2013, Achim Rosenhagen
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

case node['platform_family']
when 'debian'
   bash "remove_vmware-tools" do
    code <<-EOH
    apt-get remove -y 'vmware*'
    if [ -f /etc/yum.repos.d/vmware-tools.repo ]; then
      rm -f /etc/yum.repos.d/vmware-tools.repo
    fi
    if [ -d /usr/lib/vmware-tools ]; then
      rm -rf /usr/lib/vmware-tools
    fi
    if [ -d /etc/vmware-tools ]; then
      rm -rf /etc/vmware-tools
    fi
    EOH
    only_if "dpkg --get-selections | grep  'vmware-tool'"
  end
end

# get the file
cookbook_file "#{Chef::Config['file_cache_path']}/#{node['vmware-tools']['tarball']}" do
  source "#{node['vmware-tools']['tarball']}"
  cookbook node['vmware-tools']['src']['cookbook']
  checksum "#{node['vmware-tools']['checksum']}"
  mode 00644
  only_if { node['vmware-tools']['src']['file'] }
  notifies :run, "execute[extract_vmware-tools]", :immediately
end

# extract tarball
execute 'extract_vmware-tools' do
  command "tar xzf #{Chef::Config['file_cache_path']}/#{node['vmware-tools']['tarball']}"
  cwd '/tmp'
end

# run uninstall script
execute 'run_vmware-tools_uninstall_script' do
  command 'vmware-uninstall-tools.pl'
  environment ({'PATH' => "#{ENV['PATH']}:/tmp/vmware-tools-distrib/bin"})
  ignore_failure true
end

# run install script
execute 'run_vmware-tools_install_script' do
  command '/tmp/vmware-tools-distrib/vmware-install.pl --default'
  notifies :delete, 'directory[/tmp/vmware-tools-distrib]'
end

# start the service
service 'vmware-tools' do
  action :start
end

# clean up
directory '/tmp/vmware-tools-distrib' do
  recursive true
  action :nothing
end