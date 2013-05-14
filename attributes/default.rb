#
# Cookbook Name:: vmware-tools
# Attributes:: default
#
# Copyright 2011, Bryan W. Berry <bryan.berry@gmail.com>
#
# Apache v2.0
#

default['esx']['version'] = ""
default['esx']['tarball'] = ""

esx_hw_id = %x[ dmidecode | grep -A4 "BIOS Information" | grep 'Address:' ].split[1]

case esx_hw_id
when "0xEA550"
  default['esx']['version'] = "4.0"
  default['esx']['tarball'] = "VMwareTools-4.0.0-208167.tar.gz"
  default['esx']['checksum'] = "f6f0d2fce35d2abdecf97a522c0b686f709758d37573a4b5dff7a86a17cc485a"
when "0xEA2E0"
  default['esx']['version'] = "4.1"
  default['esx']['tarball'] = "VMwareTools-8.3.7-341836.tar.gz"
  default['esx']['checksum'] = "112092df38d3e82e41bbeda2cf0e97a6ccfae845d6e8dd0d058d635aa994365f"
when "0xE72C0"
  default['esx']['version'] = "5.0"
  default['esx']['tarball'] = "VMwareTools-8.6.0-446312.tar.gz"
  default['esx']['checksum'] = "5118df75830e416ca20e2939e4934b4ebb8b9e29160e3fbed225aaa832345712"
when "0xEA0C0"
  default['esx']['version'] = "5.1u1"
  default['esx']['tarball'] = "VMwareTools-9.0.5-1065307.tar.gz"
  default['esx']['checksum'] = "9beba639024f6bd9eb6a345f7a1d9a14eeb480d09da6802b5d6a3fa69a9af041"
end

Chef::Log.debug("esx tarball is #{node['esx']['tarball']}")
