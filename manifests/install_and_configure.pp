class tomcat6::install_and_configure (
    $version,
    $user,
    $user_home,
    $http_port,
) {

    $tomcat_archive_base = "apache-tomcat-${version}"
    $tomcat_archive_name = "${tomcat_archive_base}.tar.gz"

    $tomcat_base_url = 'http://archive.apache.org/dist/tomcat/tomcat-6/v'
    $tomcat_wget_url = "${tomcat_base_url}${version}/bin/${tomcat_archive_name}"
    $tomcat_dest_path = "${user_home}/${tomcat_archive_base}"
    $tomcat_dest_symlink = "${user_home}/tomcat6"
    $tomcat_http_port = "${http_port}"
    $tomcat_user = { name => "admin", password => "admin", roles => 'tomcat,admin,manager,manager-gui' }

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
    }->

    class { 'tomcat6::configure':
        tomcat_directory  => "${tomcat_dest_path}",
    }

    file { 'symlink_tomcat6':
        ensure  => link,
        owner   => "$user",
        group   => "$user",
        path    => "${tomcat_dest_symlink}",
        target  => "${tomcat_dest_path}",
    }
}
