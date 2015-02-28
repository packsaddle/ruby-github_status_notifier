# GithubStatusNotifier

[![Gem Version](http://img.shields.io/gem/v/github_status_notifier.svg?style=flat)](http://badge.fury.io/rb/github_status_notifier)
[![Build Status](http://img.shields.io/travis/packsaddle/ruby-github_status_notifier/master.svg?style=flat)](https://travis-ci.org/packsaddle/ruby-github_status_notifier)

## Usage

```
# before your command
$ github-status-notifier notify --state pending

$ SOME_YOUR_COMMAND

# after your command
$ github-status-notifier notify --exit-status $?
```

![GitHub Status](https://cloud.githubusercontent.com/assets/75448/6426125/d4bd4bb8-bf8c-11e4-829e-79b02bb7d6f2.png)

## Commands

```
Commands:
  github-status-notifier help [COMMAND]  # Describe available commands or one specific command
  github-status-notifier notify          # Notify current status to GitHub status
  github-status-notifier version         # Show the GithubStatusNotifier version

Usage:
  github-status-notifier notify

Options:
  [--exit-status=N]
  [--keep-exit-status], [--no-keep-exit-status]
  [--debug], [--no-debug]
  [--verbose], [--no-verbose]
  [--state=STATE]
                                                 # Possible values: pending, success, error, failure
  [--target-url=TARGET_URL]
  [--description=DESCRIPTION]
  [--context=CONTEXT]

Notify current status to GitHub status
```

see also: [Statuses | GitHub API](https://developer.github.com/v3/repos/statuses/)

## VS.

### [github-commit-status-updater](https://github.com/joker1007/github-commit-status-updater)

```
Commands:
  github-commit-status-updater error -r, --repo=REPO -s, --sha1=SHA1    # commit status error
  github-commit-status-updater failure -r, --repo=REPO -s, --sha1=SHA1  # commit status failure
  github-commit-status-updater help [COMMAND]                           # Describe available commands or one specific command
  github-commit-status-updater pending -r, --repo=REPO -s, --sha1=SHA1  # commit status pending
  github-commit-status-updater success -r, --repo=REPO -s, --sha1=SHA1  # commit status success
```

`github-commit-status-updater` is very simple, but I want to detect `repo` and `sha1` automatically.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'github_status_notifier'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install github_status_notifier

## Setting

require setting `GITHUB_ACCESS_TOKEN` to your environment variable.



## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment. Run `bundle exec github_status_notifier` to use the code located in this directory, ignoring other installed copies of this gem.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/packsaddle/ruby-github_status_notifier/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
