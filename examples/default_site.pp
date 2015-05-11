Exec {
    path => [ '/usr/bin', '/bin', '/usr/sbin', '/sbin' ]
}

package { [ 'unzip', 'curl' ]: }

class { 'tomcat6':
    require => [ Package['unzip'], Package['curl'] ],
}
