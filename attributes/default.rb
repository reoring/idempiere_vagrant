node.default['postgresql']['enable_pgdg_yum'] = true
node.default['postgresql']['version'] = "9.2"
node.default['postgresql']['dir'] = "/var/lib/pgsql/9.2/data"
node.default['postgresql']['client']['packages'] = ["postgresql92", "postgresql92-devel"]
node.default['postgresql']['server']['packages'] = ["postgresql92-server"]
node.default['postgresql']['server']['service_name'] = "postgresql-9.2"
node.default['postgresql']['contrib']['packages'] = ["postgresql92-contrib"]
