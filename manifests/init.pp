# Class: appstore
#
# This module installs apps via the Mac App Store
#
class appstore(
  $store    = $appstore::store,
  $appleid  = $appstore::appleid,
  $password = $appstore::password,
) {

  include boxen::config

  file { "${boxen::config::home}/appstore.app":
    ensure  => directory,
    source  => 'puppet:///modules/appstore/appstore.app',
    recurse => true,
  }

  $db     = '/Library/Application Support/com.apple.TCC/TCC.db'
  $sqlite = '/usr/bin/sqlite3'
  $app_id = 'com.xdissent.boxen.appstore'
  $svc    = 'kTCCServiceAccessibility'
  $insert = "INSERT OR REPLACE INTO access VALUES ('${svc}', '${app_id}', 0, 1, 0, NULL);"
  $select = "SELECT client FROM access WHERE allowed=1 AND client='${app_id}';"

  exec { 'appstore-accessibility':
    command => "${sqlite} '${db}' \"${$insert}\"",
    user    => 'root',
    unless  => "${sqlite} '${db}' \"${select}\" | grep -q '${app_id}'",
  }

  Class['appstore'] -> Appstore::App <| |>
}