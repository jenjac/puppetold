# Class: launchd_puppet
# ===========================
#
# Full description of class launchd_puppet here.
#
# Parameters
# ----------
#
# Document parameters here.
#
# * `sample parameter`
# Explanation of what this parameter affects and what it defaults to.
# e.g. "Specify one or more upstream ntp servers as an array."
#
# Variables
# ----------
#
# Here you should define a list of variables that this module would require.
#
# * `sample variable`
#  Explanation of how this variable affects the function of this class and if
#  it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#  External Node Classifier as a comma separated list of hostnames." (Note,
#  global variables should be avoided in favor of class parameters as
#  of Puppet 2.6.)
#
# Examples
# --------
#
# @example
#    class { 'launchd_puppet':
#      servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#    }
#
# Authors
# -------
#
# Author Name <author@domain.com>
#
# Copyright
# ---------
#
# Copyright 2018 Your name here, unless otherwise noted.

class launchd_puppet {
    file { 'post-hook':
        ensure  => file,
        path    => '/etc/puppetlabs/code/environments/.git/hooks/post-merge',
        source  => 'puppet:///modules/launchd_puppet/post-merge',
        mode    => '0755',
        owner   => root,
        group   => wheel,
    }
    file { '/Library/PrivilegedHelperTools':
        ensure  => directory,
        mode    => '0644',
        owner   => root,
        group   => wheel,
    }
    file { '/Library/PrivilegedHelperTools/edu.bethel.puppet':
        ensure  => directory,
        mode    => '0644',
        owner   => root,
        group   => wheel,
    }
    file { 'run-puppet':
        ensure  => file,
        path    => '/Library/PrivilegedHelperTools/edu.bethel.puppet/run-puppet',
        source  => 'puppet:///modules/launchd_puppet/run-puppet',
        mode    => 'u+x',
        owner   => root,
        group   => wheel,
    }
    launchd::job {'edu.bethel.puppet':
        ensure  => 'present',
        program => '/Library/PrivilegedHelperTools/edu.bethel.puppet/run-puppet',
        run_at_load => true,
	start_interval => 1800,
    }
}

