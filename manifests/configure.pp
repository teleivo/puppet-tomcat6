class tomcat6::configure (
    $tomcat_directory,
) {

    file { 'server.xml':
        path    => "${tomcat_directory}/conf/server.xml",
        ensure  => file,
        content => template("tomcat6/server.xml.erb"),
    }->

    file { 'tomcat-users.xml':
        path    => "${tomcat_directory}/conf/tomcat-users.xml",
        ensure  => file,
        content => template("tomcat6/tomcat-users.xml.erb"),
    }
}
