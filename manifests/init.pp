class tomcat6 (
    $version = '6.0.29',
    $user = 'tomcat6',
    $user_home = '/opt/tomcat6',
    $http_port = '8080',
    $java_opts = ['-Djava.awt.headless=true', '-Xmx128m', '-XX:+UseConcMarkSweepGC'],
    $tomcat_users = undef,
) {
    $archive_basename = "apache-tomcat-${version}"
    $home_path = "${user_home}/${archive_basename}"
    $staging_dir = "${user_home}/staging/"
    $staging_home_path = "${staging_dir}${archive_basename}"

    user { $user:
        ensure      => present,
        home        => $user_home,
        managehome  => true,
    }

    class { 'tomcat6::staging':
        require => User["$user"],
    }

    class { 'tomcat6::install':
        require => Class['tomcat6::staging'],
    }

    class { 'tomcat6::config':
        require => Class['tomcat6::install'],
    }

    class { 'tomcat6::service':
        require => Class['tomcat6::config'],
    }
}
