class cassandra {
    exec {
        "install-epel":
            command => "rpm -Uvh http://download.fedoraproject.org/pub/epel/5/x86_64/epel-release-5-4.noarch.rpm",
            creates => "/etc/yum.repos.d/epel.repo";
    }
    package { 
        "cassandra":
            name    => "apache-cassandra1",
            ensure  => present;
        "opscenter-free":
            ensure  => present,
            require => Package["cassandra"];
        "java-1.6.0-sun":
            ensure  => present;
    }

    yumrepo {
        "datastax":
            descr       => "DataStax Repo for Apache Cassandra",
            baseurl     => "http://rpm.datastax.com/community",
            enabled     => 1,
            gpgcheck    => 0;
    }

    Exec["install-epel"] -> Yumrepo["datastax"] -> Package["cassandra"]
}
