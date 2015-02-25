class tomcat6::configure (
    $tomcat6_home_path,
    $tomcat6_http_port,
    $tomcat6_conf_users = undef,
) {

    file { 'server.xml':
        path    => "${tomcat6_home_path}/conf/server.xml",
        ensure  => file,
        content => template("tomcat6/server.xml.erb"),
    }->

    file { 'tomcat-users.xml':
        path    => "${tomcat6_home_path}/conf/tomcat-users.xml",
        ensure  => file,
        content => template("tomcat6/tomcat-users.xml.erb"),
    }
}
