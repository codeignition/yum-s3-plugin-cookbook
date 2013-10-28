#
# Cookbook Name:: yum-s3-plugin
# Recipe:: default
#
# Copyright (C) 2013 SinisterLight
# 
# All rights reserved - Do Not Redistribute
#

package 'git-core'
package 'rpm-build'

execute "install epel repo" do
  command "rpm -Uvh http://mirrors.kernel.org/fedora-epel/6/i386/epel-release-6-8.noarch.rpm" 
  not_if { ::File.exists? "/etc/yum.repos.d/epel.repo" }
end

package 's3cmd'

temp_dir = Chef::Config['file_cache_path']
execute 'git_clone_yum_s3_plugin' do
  command "git clone https://github.com/jbraeuer/yum-s3-plugin.git"
  creates "/#{temp_dir}/yum-s3-plugin"
end

script 'install_yum_s3_plugin' do
  interpreter '/bin/bash'
  cwd "/#{temp_dir}/yum-s3-plugin"
  code './package -d'
end

package "/#{temp_dir}/yum-s3-plugin/RPMS/noarch/yum-s3-0.2.4-1.noarch.rpm"
