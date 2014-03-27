janus
=====

[![Build Status](https://travis-ci.org/bradgignac/janus.png?branch=master)](https://travis-ci.org/bradgignac/janus)
[![Code Climate](https://codeclimate.com/github/bradgignac/janus.png)](https://codeclimate.com/github/bradgignac/janus)
[![Dependency Status](https://gemnasium.com/bradgignac/janus.png)](https://gemnasium.com/bradgignac/janus)

Janus is a tool for performing automated visual regression testing against web
applications. It works by comparing screenshots of your application in a known
good state to fresh screenshots of your application. A number of [similar tools exist](#inspiration),
but Janus excels for projects with the following needs:

- *Automated testing across a large number of browsers and operating systems.*
Janus was built with multi-browser support as a primary concern. By building on top
of Sauce Labs' testing platform, you have access to the full array of [Sauce Labs platforms](https://saucelabs.com/docs/platforms).

- *Testing of applications where subtle visual differences are allowed.*
Many visual regression testing tools fail whenever they find a single-pixel
difference in a screenshot. Janus allows you to define a threshold within which
screenshots are still considered valid.

## Getting Started

To get started, install Janus by running:

    $ gem install janus

Or by adding Janus to your Gemfile:

    $ gem 'janus'

Once Janus is installed, run:

    $ janus init

This will generate a sample configuration file in the current directory. See
[Configuring Janus](#configuring-janus) for more information about valid configuration
options. Once you've finishing adding tests to your configuration file, you are
ready to begin running tests:

    $ janus record

This will generate screenshots for all combinations of tests and browsers located
in your configuration file. Commit these screenshots to source control alongside
your source code. Whenever you wish to verify your UI, running `janus validate`
will compare fresh screenshots against the screenshots you've previously recorded.
Re-run `janus record` to generate fresh screenshots at any time. See the [example](example)
directory for an example of Janus in action.

## Configuring Janus

**tests** (required)

An array of screenshots to take. Each entry in the array contains a name and
URL. All URLs are relative to the specified base URL.

**browsers** (required)

An array of browsers to run your tests against. Each entry in the array contains
a platform, browser, and optional version. See the [Sauce Labs platform documentation](https://saucelabs.com/docs/platforms)
for more information on the valid browsers.

**source** (required)

The source from which screenshots will be recorded. This parameter accepts a hash
of options. See [Source Drivers](#source-drivers) for more information.

**output** (required)

The output to which screenshots will be persisted. This parameter accepts a hash
of options. See [Output Drivers](#output-drivers) for more information.

**threshold** (optional)

The percentage of change that is allowed in a screenshot. This value can be
overridden for each individual test. *Defaults to 0*.

## Source Drivers

**Sauce Labs**

```
source:
  type: sauce
  tunnel: true    # Whether or not to start a Sauce Connect tunnel.
```

Additionally, the Sauce Labs driver expects the SAUCE_USERNAME and SAUCE_ACCESS_KEY
environment variables to be set.

## Output Drivers

**Directory**

```
output:
  type: directory
  path: path/to/screenshot    # Path to which screenshots will be saved.
```

## Best Practices

- *Create tests for small units of your UI.* Just like with unit tests, create
screenshot tests for small components of your UI. This will help create a more
reliable test suite and help you catch visual regressions.
- *Create tests for larger combinations of your UI components.* Unfortunaly, "unit"
tests won't catch everything. Create larger "integration" tests that combine
individual UI components. This will help you test that all of your components play
well together.
- *Use per-test thresholds to keep variations small.* A global threshold is great,
but some tests have a higher than normal variance. Raising the global threshold
will increase the chances of missing regressions in your other tests. Instead,
simply add a threshold for the test that requires a larger variance.

## Inspiration

Janus was inspired by the following projects:

- [GreenOnion](http://intridea.github.io/green_onion)
- [huxley](https://github.com/facebook/huxley)
- [wraith](https://github.com/BBC-News/wraith)

## License

Janus is released under the [MIT License](LICENSE).
