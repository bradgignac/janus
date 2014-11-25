janus
=====

[![Build Status](https://travis-ci.org/bradgignac/janus.png?branch=master)](https://travis-ci.org/bradgignac/janus)

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

## Inspiration

Janus was inspired by the following projects:

- [GreenOnion](http://intridea.github.io/green_onion)
- [huxley](https://github.com/facebook/huxley)
- [wraith](https://github.com/BBC-News/wraith)

## License

Janus is released under the [MIT License](LICENSE).
