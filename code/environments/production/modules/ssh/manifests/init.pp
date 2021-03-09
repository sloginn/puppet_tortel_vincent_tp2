class ssh ($permitroot="no") {
    package { 'openssh-server':
       ensure => installed,
    }
    case $::osfamily {
 	'Debian': { $sshd_service = 'ssh' }
        'RedHat': { $sshd_service = 'sshd' }
	 default: {fail("Invalid osfamily: ${::osfamily}")}
    }
 
    file { '/etc/ssh/sshd_config':
	content => template("ssh/sshd_config.erb"),	
#        source => 'puppet:///modules/ssh/sshd_config',
        owner => 'root',
        group => 'root',
        mode => '640',
        notify => Service['sshd'], # sshd will restart whenever you edit this file.
        require => Package['openssh-server'],
    }
    service { 'sshd':
	name => $sshd_service,
        ensure => running,
        enable => true,
        hasstatus => true,
        hasrestart => true,
    }
    

}
