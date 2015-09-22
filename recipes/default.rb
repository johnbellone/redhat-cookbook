#
# Cookbook: redhat
# License: Apache 2.0
#
# Copyright 2014-2015, Bloomberg Finance L.P.
#

redhat_subscription node['fqdn'] do
  node['redhat']['subscription'].each_pair { |k, v| send(k, v) }
end
