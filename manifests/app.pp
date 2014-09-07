# Type: appstore::app
#
# Usage:
#
#   appstore::app { 'Twitter':
#     source: 'twitter/id409789998',
#   }
#
define appstore::app(
  $source,
) {
  require appstore

  $app_path = "/Applications/${title}.app"

  exec { "appstore-app-${title}":
    command     => "open -W '${boxen::config::home}/appstore.app'",
    creates     => $app_path,
    environment => [
      "BOXEN_APPSTORE_SOURCE=macappstore://itunes.apple.com/${appstore::store}/app/${source}",
      "BOXEN_APPSTORE_ID=${appstore::appleid}",
      "BOXEN_APPSTORE_PASSWORD=${appstore::password}",
    ]
  }
  ->
  file { "appstore-app-${title}-check":
    ensure  => present,
    path    => $app_path,
    user    => 'root',
    group   => 'wheel',
  }
}