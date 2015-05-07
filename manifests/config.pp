class tomcat6::config (
) {
    $tomcat6_http_port = $tomcat6::http_port
    $tomcat6_conf_users = $tomcat6::tomcat_users

    $tomcat6_server_xml_path = "${tomcat6::home_path}/conf/server.xml"
    $tomcat6_users_xml_path = "${tomcat6::home_path}/conf/tomcat-users.xml"

    file { "${tomcat6_server_xml_path}":
        ensure  => file,
        content => template("tomcat6/server.xml.erb"),
    }->

    file { "${tomcat6_users_xml_path}":
        ensure  => file,
        content => template("tomcat6/tomcat-users.xml.erb"),
    }
}
