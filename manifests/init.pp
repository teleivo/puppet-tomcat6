class tomcat6 (
    $user = undef) {
    
    class { 'tomcat6::install': user => $user }
}

class tomcat6::install (
    $user = undef) {
    
    $tomcat_url = 'http://archive.apache.org/dist/tomcat/tomcat-6/v6.0.29/bin/apache-tomcat-6.0.29.tar.gz'
    $tomcat_archive_name = 'apache-tomcat-6.0.29.tar.gz'
    $tomcat_folder_name = 'apache-tomcat-6.0.29'
    $install_base_dir = '/opt'
    $install_path = "${install_base_dir}/${tomcat_folder_name}"

    user { $user:
        ensure  => present
    }->

    exec { 'tomcat6-wget':
        cwd     => '/tmp',
        user    => 'root',
        group   => 'root',
        path    => '/usr/bin',
        command => "wget ${tomcat_url}"
    }->

    exec { 'tomcat6-untar':
        cwd     => '/tmp',
        user    => 'root',
        group   => 'root',
        path    => '/bin',
        command => "tar xzf ${tomcat_archive_name} -C ${install_base_dir}"
    }->

    exec { 'tomcat6-chown':
        cwd     => "${install_base_dir}",
        user    => 'root',
        group   => 'root',
        path    => '/bin',
        command => "chown -R ${user}.${user} ${install_path}"
    }->

    file { 'tomcat6-symlink':
        path    => "${install_base_dir}/tomcat6",
        ensure  => link,
        target  => "${install_path}",
        owner   => "${user}",
        group   => "${user}",
    }
}
