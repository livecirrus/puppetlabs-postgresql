# PRIVATE CLASS: do not use directly
class postgresql::server::reload {
  $ensure         = $postgresql::server::ensure
  $enable         = $postgresql::server::enable
  $service_name   = $postgresql::server::service_name
  $service_status = $postgresql::server::service_status
  $version        = $postgresql::server::version
  if($ensure == 'present' or $ensure == true) {
    if ($enable == 'manual') {
      exec { 'postgresql_reload':
        path        => '/usr/bin:/usr/sbin:/bin:/sbin',
        command     => "pg_ctlcluster ${version} main reload",
        onlyif      => $service_status,
        refreshonly => true,
      }
    }      
    else {
	    exec { 'postgresql_reload':
	      path        => '/usr/bin:/usr/sbin:/bin:/sbin',
	      command     => "service ${service_name} reload",
	      onlyif      => $service_status,
	      refreshonly => true,
	    }
    }
  }
}
