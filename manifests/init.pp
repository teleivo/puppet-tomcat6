class tomcat6 (
    $version = '6.0.29',
    $user = 'tomcat6',
    $user_home = '/opt/tomcat6',
    $http_port = '8080',
    $java_opts = ['-Djava.awt.headless=true', '-Xmx128m', '-XX:+UseConcMarkSweepGC'],
    $tomcat_users = undef,
) {
    $tomcat6_archive_basename = "apache-tomcat-${version}"
    $tomcat6_home_path = "${user_home}/${tomcat6_archive_basename}"

    class { 'tomcat6::install':
        version                  => $version,
        user                     => $user,
        user_home                => $user_home,
        tomcat6_archive_basename => $tomcat6_archive_basename,
        tomcat6_home_path        => $tomcat6_home_path,
    }->

    class { 'tomcat6::configure':
        tomcat6_home_path  => $tomcat6_home_path,
        tomcat6_http_port  => $http_port,
        tomcat6_conf_users => $tomcat_users,
    }->

    class { 'tomcat6::service':
        tomcat6_user        => $user,
        tomcat6_home_path   => $tomcat6_home_path,
        tomcat6_lib_path    => $tomcat6_home_path,
        tomcat6_java_opts   => $java_opts,
    }
}
