class tomcat6 (
    $user = 'tomcat6',
    $user_home = '/opt/tomcat6',
    $http_port = '8080',
) {

    class { 'tomcat6::install':
        user => $user,
        user_home => $user_home,
        http_port => $http_port,
    }
}
