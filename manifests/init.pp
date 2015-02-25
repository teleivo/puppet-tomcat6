class tomcat6 (
    $version = '6.0.29',
    $user = 'tomcat6',
    $user_home = '/opt/tomcat6',
    $http_port = '8080',
    $java_opts = '-Djava.awt.headless=true -Xmx128m -XX:+UseConcMarkSweepGC',
) {

    class { 'tomcat6::install_and_configure':
        version     => $version,
        user        => $user,
        user_home   => $user_home,
        http_port   => $http_port,
        java_opts   => $java_opts,
    }
}
