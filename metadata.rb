name             'idempiere'
maintainer       'reoring'
maintainer_email 'reoring@craftsman-software.com'
license          'Craftsman Software, Inc. All rights reserved'
description      'Installs/Configures idempiere'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

# depends "tomcat", "~> 0.15.0"
depends "java", "~> 1.15.0"
depends "postgresql", "~> 3.3.0"
depends "database", "~> 1.5.0"
depends "simple_iptables", "~> 0.3.0"
