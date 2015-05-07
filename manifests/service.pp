class tomcat6::service (
) {
    $tomcat6_user = $tomcat6::user
    $tomcat6_home_path = $tomcat6::home_path
    $tomcat6_lib_path = $tomcat6::home_path
    $tomcat6_java_opts = $tomcat6::java_opts

    $initd_script_name = "tomcat6"

    file { "/etc/default/${initd_script_name}":
        ensure  => present,
        mode    => 644,
        owner   => "root",
        group   => "root",
        content => template("tomcat6/etc/default/${initd_script_name}.erb"),
        notify  => Service[$initd_script_name],
    }->

    file { "/etc/init.d/${initd_script_name}":
        ensure  => present,
        mode    => 755,
        owner   => "root",
        group   => "root",
        content => template("tomcat6/etc/init.d/${initd_script_name}.erb"),
        notify   => Service[$initd_script_name],
    }->

    service { "$initd_script_name":
        ensure => running,
        enable => true,
    }
}
