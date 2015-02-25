class tomcat6::install (
    $version,
    $user,
    $user_home,
    $tomcat6_archive_basename,
    $tomcat6_home_path,
) {
    $tomcat_archive_name = "${tomcat6_archive_basename}.tar.gz"
    $tomcat_base_url = 'http://archive.apache.org/dist/tomcat/tomcat-6/v'
    $tomcat_wget_url = "${tomcat_base_url}${version}/bin/${tomcat_archive_name}"

    user { $user:
        ensure  => present,
        home => "${user_home}",
        managehome => true,
    }->

    exec { 'wget_tomcat6':
        cwd     => "${user_home}",
        user    => "${user}",
        group   => "${user}",
        path    => '/usr/bin',
        command => "wget ${tomcat_wget_url}",
    }->

    exec { 'untar_tomcat6':
        cwd     => "${user_home}",
        user    => "${user}",
        group   => "${user}",
        path    => '/bin',
        command => "tar xzf ${tomcat_archive_name}",
    }

    if ($version == '6.0.29') {
        file { "${tomcat6_home_path}/bin/catalina.sh":
            ensure  => file,
            owner   => "$user",
            group   => "$user",
            mode    => 755,
            source  => "puppet:///modules/tomcat6/catalina.sh",
            require => Exec['untar_tomcat6'],
        }
    }
}
