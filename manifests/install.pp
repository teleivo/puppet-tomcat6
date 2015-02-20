class tomcat6::install (
    $version,
    $user,
    $user_home,
    $http_port,
) {

    $tomcat_archive_base = "apache-tomcat-${version}"
    $tomcat_archive_name = "${tomcat_archive_base}.tar.gz"

    $tomcat_base_url = 'http://archive.apache.org/dist/tomcat/tomcat-6/v'
    $tomcat_url = "${tomcat_base_url}${version}/bin/${tomcat_archive_name}"
    $tomcat_dest_path = "${user_home}/${tomcat_archive_base}"
    $tomcat_dest_symlink = "${user_home}/tomcat6"
    $tomcat_http_port = "${http_port}"
    $tomcat_user = { name => "admin", password => "admin", roles => 'tomcat,admin,manager,manager-gui' }

    user { $user:
        ensure  => present,
        home => "${user_home}",
        managehome => true,
    }->

    exec { 'tomcat6_install_wget':
        cwd     => "${user_home}",
        user    => "${user}",
        group   => "${user}",
        path    => '/usr/bin',
        command => "wget ${tomcat_url}",
    }->

    exec { 'tomcat6_install_untar':
        cwd     => "${user_home}",
        user    => "${user}",
        group   => "${user}",
        path    => '/bin',
        command => "tar xzf ${tomcat_archive_name}",
    }->

    file { 'server.xml':
        path    => "${tomcat_dest_path}/conf/server.xml",
        ensure  => file,
        content => template("tomcat6/server.xml.erb"),
    }->

    file { 'tomcat-users.xml':
        path    => "${tomcat_dest_path}/conf/tomcat-users.xml",
        ensure  => file,
        content => template("tomcat6/tomcat-users.xml.erb"),
    }->

    file { 'tomcat6_install_symlink':
        ensure  => link,
        owner   => "$user",
        group   => "$user",
        path    => "${tomcat_dest_symlink}",
        target  => "${tomcat_dest_path}",
    }
}

