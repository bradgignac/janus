janus
=====

[![Build Status](https://travis-ci.org/bradgignac/janus.png?branch=master)](https://travis-ci.org/bradgignac/janus)
[![Code Climate](https://codeclimate.com/github/bradgignac/janus.png)](https://codeclimate.com/github/bradgignac/janus)
[![Dependency Status](https://gemnasium.com/bradgignac/janus.png)](https://gemnasium.com/bradgignac/janus)

Janus is a tool for performing automated *visual* regression testing against web
applications. A number of [similar tools exist](#inspiration), but Janus excels for projects with
the following needs:

- *Automated testing across a large number of browsers and operating systems.*
Janus built with multi-browser support as a primary concern. By building on top
of Sauce Labs' testing platform, you have access to the full array of [Sauce Labs platforms](https://saucelabs.com/docs/platforms).

- *Testing of applications where subtle visual differences are allowed.*
Many visual regression testing tools fail whenever they find a single-pixel
difference in a screenshot. Janus allows you to define a threshold within which
screenshots are still considered valid.

## Installation

To get started with Janus, simply run:

    $ gem install janus
    $ janus init

This will install the Janus binary and generate a sample configuration file. See
[Defining a Test Suite](#defining-a-test-suite) for more information on defining
your test suite.

## Defining a Test Suite

Coming soon...

## Running Tests

Coming soon...

## Best Practices

- *Create tests for small units of your UI.*
- *Create tests for larger combinations of your UI components.*
- *Use per-test thresholds to keep variations small.*

## Getting Help

If you are having trouble getting started with Janus, take a look at the
[example](example) directory for an example of Janus in use. If you're still
having trouble or have found a bug, feel free to [submit an issue](issues).

## Inspiration

Janus is built with inspiration from the following projects:

- [GreenOnion](http://intridea.github.io/green_onion)
- [huxley](https://github.com/facebook/huxley)
- [wraith](https://github.com/BBC-News/wraith)

## Contributing

Coming soon...

## License

Janus is released under the [MIT License](LICENSE).
