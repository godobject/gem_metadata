GemMetadata
===========

[![Gem Version](https://badge.fury.io/rb/gem_metadata.png)](https://badge.fury.io/rb/gem_metadata)
[![Dependency Status](https://gemnasium.com/godobject/gem_metadata.png)](https://gemnasium.com/godobject/gem_metadata)
[![Code Climate](https://codeclimate.com/github/godobject/gem_metadata.png)](https://codeclimate.com/github/godobject/gem_metadata)
[![Build Status](https://secure.travis-ci.org/godobject/gem_metadata.png)](https://secure.travis-ci.org/godobject/gem_metadata)
[![Coverage Status](https://coveralls.io/repos/github/godobject/gem_metadata/badge.svg?branch=master)](https://coveralls.io/github/godobject/gem_metadata?branch=master)

* [Documentation][docs]
* [Project][project]

   [docs]:    http://rdoc.info/github/godobject/gem_metadata/
   [project]: https://github.com/godobject/gem_metadata/

Description
-----------

GemMetadata is a Ruby library that allows to filter and access gems by custom
metadata keys that their specifications contain.

Features / Problems
-------------------

This project tries to conform to:

* [Semantic Versioning (2.0.0)][semver]
* [Ruby Packaging Standard (0.5-draft)][rps]
* [Ruby Style Guide][style]
* [Gem Packaging: Best Practices][gem]

   [semver]: http://semver.org/spec/v2.0.0.html
   [rps]:    http://chneukirchen.github.com/rps/
   [style]:  https://github.com/bbatsov/ruby-style-guide
   [gem]:    http://weblog.rubyonrails.org/2009/9/1/gem-packaging-best-practices

Additional facts:

* Written purely in Ruby.
* Documented with Cucumber.
* Automatically testable through Cucumber and RSpec.
* Intended to be used with Ruby 2.3.0 or higher.
* Cryptographically signed git tags.

Requirements
------------

* Ruby 2.3.0 or higher

Installation
------------

On *nix systems you may need to prefix the command with `sudo` to get root
privileges.

### Gem

    gem install gem_metadata

### Automated testing

Go into the root directory of the installed gem and run the following command
to fetch all development dependencies:

    bundle

Afterwards start the test runner:

    rake test

If something goes wrong you should be notified through failing examples.

Usage
-----

This documentation defines the public interface of the software. The version
number of the software tracks changes to this public interface as described in
[Semantic Versioning][semver]. Do not use elements that are marked as private.
These elements are not guaranteed to exist in otherwise compatible future
versions. Should you really need some parts that are currently marked as
private, please contact us. We might be able to expose them as public
interface for your convenience.

This is still experimental software, even the public interface may change
substantially in future releases.

   [semver]: http://semver.org/spec/v2.0.0.html

### Ruby interface

#### Loading

In most cases you want to load the code by using the following command:

~~~~~ ruby
require 'gem_metadata'
~~~~~

In a bundler Gemfile you should use the following:

~~~~~ ruby
gem 'gem_metadata'
~~~~~

#### Namespace

This project is contained within a namespace to avoid name collisions with
other code. If you do not want to specifiy the namespace explicitly you can
include it into the current scope by executing the following statement:

~~~~~ ruby
include GodObject::GemMetadata
~~~~~

Development
-----------

### Bug reports and feature requests

Please use the [issue tracker][issues] on github.com to let me know about errors
or ideas for improvement of this software.

   [issues]: https://github.com/godobject/gem_metadata/issues/

### Source code

#### Distribution

This software is developed in the source code management system Git. There are
several synchronized mirror repositories available:

* [GitHub][github] (located in California, USA)
    
    URI: https://github.com/godobject/gem_metadata.git

* [GitLab][gitlab] (located in Illinois, USA)
    
    URI: https://gitlab.com/godobject/gem_metadata.git

* [BitBucket][bitbucket] (located in California, USA)
    
    URI: https://bitbucket.org/godobject/gem_metadata.git

* [Pikacode][pikacode] (located in France)

    URI: https://pikacode.com/godobject/gem_metadata.git

   [github]:    https://github.com/godobject/gem_metadata/
   [gitlab]:    https://gitlab.com/godobject/gem_metadata/
   [bitbucket]: https://bitbucket.org/godobject/gem_metadata/
   [pikacode]:  https://pikacode.com/godobject/gem_metadata/

You can get the latest source code with the following command, while
exchanging the placeholder for one of the mirror URIs:

    git clone MIRROR_URI

#### Tags and cryptographic verification

The final commit before each released gem version will be marked by a tag
named like the version with a prefixed lower-case "v". Every tag will be signed
by Alexander E. Fischer's [OpenPGP public key][openpgp] which enables you to
verify your copy of the code cryptographically.

   [openpgp]: https://aef.name/crypto/aef-openpgp.asc

Add the key to your GnuPG keyring by the following command:

    gpg --import aef-openpgp.asc

This command will tell you if your code is of integrity and authentic:

    git tag --verify [TAG NAME]

#### Building gems

To package your state of the source code into a gem package use the following
command:

    rake build

The gem will be generated according to the .gemspec file in the project root
directory and will be placed into the pkg/ directory.

### Contribution

Help on making this software better is always very appreciated. If you want
your changes to be included in the official release, please clone the project
on github.com, create a named branch to commit, push your changes into it and
send a pull request afterwards.

Please make sure to write tests for your changes so that no one else will break
them when changing other things. Also notice that an inclusion of your changes
cannot be guaranteed before reviewing them.

The following people were involved in development:

* Alexander E. Fischer <aef@godobject.net>

License
-------

Copyright Alexander E. Fischer <aef@godobject.net>, 2016

This file is part of GemMetadata.

Permission to use, copy, modify, and/or distribute this software for any
purpose with or without fee is hereby granted, provided that the above
copyright notice and this permission notice appear in all copies.

THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH
REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND
FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT,
INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM
LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR
OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
PERFORMANCE OF THIS SOFTWARE.
