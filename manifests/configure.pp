class tomcat6::configure (
    $tomcat6_directory,
    $tomcat6_http_port,
    $tomcat6_conf_users,
) {

    file { 'server.xml':
        path    => "${tomcat6_directory}/conf/server.xml",
        ensure  => file,
        content => template("tomcat6/server.xml.erb"),
    }->

    file { 'tomcat-users.xml':
        path    => "${tomcat6_directory}/conf/tomcat-users.xml",
        ensure  => file,
        content => template("tomcat6/tomcat-users.xml.erb"),
    }
}
