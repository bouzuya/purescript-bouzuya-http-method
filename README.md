# purescript-bouzuya-http-method

HTTP method.

## Badge

[![Travis CI][travis-ci-badge]][travis-ci]
[![Bower][bower-badge]][bower]
[![Pursuit][pursuit-badge]][pursuit]

## Installation

```
bower install purescript-bouzuya-http-method
```

## Documentation

Module documentation is [published on Pursuit][pursuit].

## How to build

See: [`.travis.yml`](.travis.yml).

## How to publish

(first time)

```sh
$ $(npm bin)/bower login --token $GITHUB_TOKEN
$ $(npm bin)/bower register purescript-bouzuya-http-method https://github.com/bouzuya/purescript-bouzuya-http-method.git
```

```sh
$ npm run pulp:version [BUMP] # major or minor or patch
$ git push origin master
$ git push --tags
$ # npm run pulp:publish # run by Travis CI
```

[bower]: https://github.com/bouzuya/purescript-bouzuya-http-method
[bower-badge]: https://img.shields.io/bower/v/purescript-bouzuya-http-method.svg
[pursuit]: https://pursuit.purescript.org/packages/purescript-bouzuya-http-method
[pursuit-badge]: https://pursuit.purescript.org/packages/purescript-bouzuya-http-method/badge
[travis-ci]: https://travis-ci.org/bouzuya/purescript-bouzuya-http-method
[travis-ci-badge]: https://img.shields.io/travis/bouzuya/purescript-bouzuya-http-method.svg
