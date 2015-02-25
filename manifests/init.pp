class tomcat6 (
    $version = '6.0.29',
    $user = 'tomcat6',
    $user_home = '/opt/tomcat6',
    $http_port = '8080',
    $java_opts = '-Djava.awt.headless=true -Xmx128m -XX:+UseConcMarkSweepGC',
    $tomcat_users = undef,
) {
    $tomcat_archive_base = "apache-tomcat-${version}"
    $tomcat_dest_path = "${user_home}/${tomcat_archive_base}"

    class { 'tomcat6::install_and_configure':
        version             => $version,
        user                => $user,
        user_home           => $user_home,
        tomcat_archive_base => $tomcat_archive_base,
        tomcat_dest_path    => $tomcat_dest_path,
    }->

    class { 'tomcat6::configure':
        tomcat6_directory  => $tomcat_dest_path,
        tomcat6_http_port  => $http_port,
        tomcat6_conf_users => $tomcat_users,
    }->

    class { 'tomcat6::service':
        tomcat6_user        => $user,
        tomcat6_home_path   => $tomcat_dest_path,
        tomcat6_lib_path    => $tomcat_dest_path,
        tomcat6_java_opts   => $java_opts,
    }
}
