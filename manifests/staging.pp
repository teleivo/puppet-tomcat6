class tomcat6::staging (
) {
    $tomcat_archive_name = "${tomcat6::archive_basename}.tar.gz"
    $tomcat_base_url = 'http://archive.apache.org/dist/tomcat/tomcat-6/v'
    $tomcat_source_url = "${tomcat_base_url}${tomcat6::version}/bin/${tomcat_archive_name}"

    file { $tomcat6::staging_dir:
        ensure => directory,
        owner  => $tomcat6::user,
        group  => $tomcat6::user,
    }

    staging::deploy { $tomcat_archive_name:
        source  => $tomcat_source_url,
        target  => $tomcat6::staging_dir,
        user    => $tomcat6::user,
        group   => $tomcat6::user,
        require => File[$tomcat6::staging_dir],
    }

    if ($tomcat6::version == '6.0.29') {
        file { "${tomcat6::staging_home_path}/bin/catalina.sh":
            ensure  => file,
            owner   => $tomcat6::user,
            group   => $tomcat6::user,
            mode    => '0755',
            source  => 'puppet:///modules/tomcat6/catalina.sh',
            require => Staging::Deploy[$tomcat_archive_name],
        }
    }
}
