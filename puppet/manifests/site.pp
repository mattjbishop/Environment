# create a new run stage to ensure certain modules are included first
stage { 'pre':
  before => Stage['main']
}

# add the baseconfig module to the new 'pre' run stage
class { 'baseconfig':
  stage => 'pre'
}

# set defaults for file ownership/permissions
File {
  owner => 'root',
  group => 'root',
  mode  => '0644',
}

# all boxes get the base config
include baseconfig

node 'frontend' {
  # include nodejs
  
  class { 'nodejs':
    manage_repo => true
  }
  
  package { 'express':
    ensure   => present,
    provider => 'npm',
	require => Class["nodejs"],
  } 
}

node 'database' {
  include mongodb
}
