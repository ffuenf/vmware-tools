Description
===========

Installs and configures vmware-tools using a tarball package that comes on the vmware ESX installation DVD.
This cookbook works quite differently from the yumrepo::vwmare-tools recipe which installs rpms from vmware's public repository.

Requirements
============

Platform
--------

* Debian

Attributes
==========

* `node['vmware-tools']['version']` - (default: "5.1u1b")
* `node['vmware-tools']['tarball']` - (default: "VMwareTools-9.0.5-1137270.tar.gz")
* `node['vmware-tools']['checksum']` - (default: "9beba639024f6bd9eb6a345f7a1d9a14eeb480d09da6802b5d6a3fa69a9af041")
* `node['vmware-tools']['src']['cookbook']` - cookbook where tarball of vmware-tools is located. If you use a wrapper cookbook you might adjust this. (default: "vmware-tools")
* `node['vmware-tools']['src']['file']` - additional switch to use the local tarball file (default: true)

License and Author
==================

Author:: Achim Rosenhagen (<a.rosenhagen@ffuenf.de>)

Copyright:: 2013, Achim Rosenhagen

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.