#!/bin/bash

# Install tools required to build the rpms
yum install -y rpm-build yum-utils rpmdevtools createrepo

# Install EPEL
rpm -ivh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm

# Go to /tmp to get and extract collectd source base
cd /tmp
wget -c http://collectd.org/files/collectd-5.5.0.tar.bz2

# Extract source
tar xvf collectd-5.5.0.tar.bz2

# Create build directory
mkdir -p /root/rpmbuild/SOURCES/

# Copy sources in build directory
cp collectd-5.5.0.tar.bz2 /root/rpmbuild/SOURCES/

# Install dependencies of the spec file
yum-builddep -y collectd-5.5.0/contrib/redhat/collectd.spec

# Create RPMS
rpmbuild -bb collectd-5.5.0/contrib/redhat/collectd.spec

# Copy RPMs back to the host
cp -rv /root/rpmbuild/RPMS/ /vagrant

