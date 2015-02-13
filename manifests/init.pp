class tomcat6 (
    $user = undef,
    $user_home = undef) {
    
    class { 'tomcat6::install': user => $user,
                                user_home => $user_home,
    }
}

class tomcat6::install (
    $user = undef,
    $user_home = undef) {
    
    $tomcat_url = 'http://archive.apache.org/dist/tomcat/tomcat-6/v6.0.29/bin/apache-tomcat-6.0.29.tar.gz'
    $tomcat_archive_name = 'apache-tomcat-6.0.29.tar.gz'
    $tomcat_folder_name = 'apache-tomcat-6.0.29'
    $tomcat_dest_path = "${user_home}/${tomcat_folder_name}"
    $tomcat_dest_symlink = "${user_home}/tomcat6"

    user { $user:
        ensure  => present,
	home => "${user_home}",
	managehome => true,
    }->

    exec { 'tomcat6-wget':
        cwd     => "${user_home}",
        user    => "${user}",
        group   => "${user}",
        path    => '/usr/bin',
        command => "wget ${tomcat_url}",
    }->

    exec { 'tomcat6-untar':
        cwd     => "${user_home}",
        user    => "${user}",
        group   => "${user}",
        path    => '/bin',
        command => "tar xzf ${tomcat_archive_name}",
    }->

    file { 'tomcat6-symlink':
        ensure  => link,
        owner   => "$user",
        group   => "$user",
        path    => "${tomcat_dest_symlink}",
        target  => "${tomcat_dest_path}",
    }
}
