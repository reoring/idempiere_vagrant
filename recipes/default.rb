#
# Cookbook Name:: idempiere
# Recipe:: default
#
# Copyright (C) 2013 reoring<reoring@craftsman-software.com>
# 
#
#
%w[unzip expect].each do |pkg|
    package pkg do 
        action :install
    end
end

# include_recipe "tomcat"
include_recipe "java"
include_recipe "postgresql::server"
p node["postgresql"]["password"]["postgres"]
include_recipe "simple_iptables"
include_recipe "idempiere::security"
include_recipe "idempiere::install"

