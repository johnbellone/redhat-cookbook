name 'redhat'
maintainer 'John Bellone'
maintainer_email 'jbellone@bloomberg.net'
license 'Apache 2.0'
description 'Wrapper cookbook which configures RHEL systems.'
long_description 'Wrapper cookbook which configures RHEL systems.'
version '0.1.0'
source_url 'https://github.com/johnbellone/redhat-cookbook' if defined?(source_url)
issues_url 'https://github.com/johnbellone/redhat-cookbook/issues' if defined?(issues_url)

supports 'centos', '>= 5.0'
supports 'redhat', '>= 5.0'
supports 'amazon'

depends 'yum'
depends 'yum-amazon'
depends 'yum-epel'
depends 'yum-centos'
