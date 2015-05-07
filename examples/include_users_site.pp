Exec {
    path => [ "/usr/bin", "/bin", "/usr/sbin", "/sbin" ]
}

class { 'tomcat6':
    tomcat_users => [
                        {   name     => "admin",
                            password => "admin",
                            roles    => 'tomcat,admin,manager,manager-gui'
                        },
                    ],
}

