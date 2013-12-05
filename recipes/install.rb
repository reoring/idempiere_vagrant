#
# Cookbook Name:: idempiere::install
# Recipe:: default
#
# Copyright (C) 2013 reoring<reoring@craftsman-software.com>
#
#

include_recipe "postgresql::ruby"

user "idempiere" do
    action :create
    home "/home/idempiere"
    shell "/bin/bash"
end

connection = {
    :host      => '127.0.0.1',
    :port      => 5432,
    :username  => 'postgres',
    :password  => 'postgres'
}

postgresql_database 'idempiere' do
  connection connection
  action :create
end

postgresql_database_user 'adempiere' do
  connection connection
  password 'adempiere'
  action :create
end

cookbook_file "/home/idempiere/idempiereServer.gtk.linux.x86_64.zip" do
    source "idempiereServer.gtk.linux.x86_64.zip"
    owner "root"
    mode 00777
end

execute "unzip idempiere" do
    cwd "/home/idempiere"
    command "unzip idempiereServer.gtk.linux.x86_64.zip"
end

execute "move idempiere" do
    cwd "/home/idempiere"
    command "mv /home/idempiere/idempiere.gtk.linux.x86_64/idempiere-server /home/idempiere/"
end

execute "remove useless directory" do
    cwd "/home/idempiere"
    command "rm -rf /home/idempiere/idempiere.gtk.linux.x86_64"
end
execute "remove archive" do
    cwd "/home/idempiere"
    command "rm -rf /home/idempiere/idempiereServer.gtk.linux.x86_64.zip"
end

execute "unzip Adempiere DDL" do
    cwd "/home/idempiere"
    command "jar xvf /home/idempiere/idempiere-server/data/seed/Adempiere_pg.jar"
end

bash "import DDL" do
    user "root"
    cwd  "/home/idempiere"
    code <<-EOH
    PGPASSWORD=postgres psql -U postgres -h 127.0.0.1 -d idempiere -f /home/idempiere/Adempiere_pg.dmp
    EOH
end

cookbook_file "/home/idempiere/idempiere-server/autoinstall.sh" do
    source "autoinstall.sh"
    owner "root"
    mode 00555
end

bash "setup idempiere" do
    user "root"
    cwd "/home/idempiere/idempiere-server"
    timeout 120
    code <<-EOH
    (cd /home/idempiere/idempiere-server && ./autoinstall.sh)
    EOH
end

execute "change permission" do
    user "root"
    command "chown -R idempiere /home/idempiere"
end

bash "setup init script" do
    user "root"
    cwd "/home/idempiere"
    code <<-EOH
    cp -Rp /home/idempiere/idempiere-server/utils/unix/idempiere_RedHat.sh /etc/init.d/idempiere
    EOH
end

service "idempiere" do
    supports :status => true, :restart => true, :reload => true
    action [ :enable, :start ]
end

bash "start" do
    user "root"
    cwd "/home/idempiere"
    code <<-EOH
    service idempiere start
    EOH
end
