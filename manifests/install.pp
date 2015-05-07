class tomcat6::install (
) {

    file { $::tomcat6::home_path:
        source  => $::tomcat6::staging_home_path,
        recurse => true,
    }
}

