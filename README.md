# puppet-appstore

Install apps from the Mac App Store with [Boxen](https://boxen.github.com).

[![Build Status](https://travis-ci.org/boxen/puppet-template.svg?branch=master)](https://travis-ci.org/boxen/puppet-template)

## Usage

Define `appstore::appleid` and `appstore::password` in your hiera config:

```yaml
---
# /opt/boxen/repo/hiera/users/xdissent.yaml

# App Store credentials:
appstore::appleid: appleid@me.com
appstore::password: jlaw4eva

# Optional App Store location:
appstore::store: us
```

Add app definitions:

```puppet
appstore::app { 'Twitter':
  source => 'twitter/id409789998', # required
}
```

To find the source ID for an app: open it in the App Store, click the popup
button to the right of the Install/Installed/Buy/Free button and choose
"Copy Link".

## Inspiration

[Demonstrate a wholly automated Xcode install](https://gist.github.com/phs/6505382)
by [Phil Smith](https://github.com/phs)

## Required Puppet Modules

* `boxen`
* [`module_data`](https://github.com/ripienaar/puppet-module-data)

## Development

Set `GITHUB_API_TOKEN` in your shell with a [Github oAuth Token](https://help.github.com/articles/creating-an-oauth-token-for-command-line-use) to raise your API rate limit. You can get some work done without it, but you're less likely to encounter errors like `Unable to find module 'boxen/puppet-boxen' on https://github.com`.

Then write some code. Run `script/cibuild` to test it. Check the `script`
directory for other useful tools.
