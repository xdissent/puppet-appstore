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

  $path = "/Applications/${title}.app"
  $helper = "${boxen::config::home}/appstore.app"

  exec { "appstore-app-${title}":
    command     => "open -W '${helper}' && [ -d '${path}' ]",
    creates     => $path,
    timeout     => 0,
    environment => [
      "BOXEN_APPSTORE_SOURCE=macappstore://itunes.apple.com/${appstore::store}/app/${source}",
      "BOXEN_APPSTORE_ID=${appstore::appleid}",
      "BOXEN_APPSTORE_PASSWORD=${appstore::password}",
    ]
  }
}