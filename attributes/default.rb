#
# Cookbook: gemrc
# License: Apache 2.0
#
# Copyright 2015-2016, Bloomberg Finance L.P.
#
default['gemrc']['path'] = '/root/.gemrc'
default['gemrc']['reload'] = false

default['gemrc']['config']['gem'] = '--no-ri --no-rdoc'
