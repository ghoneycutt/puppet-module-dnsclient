3.6.0 - 2018-12-08
  * Support Puppet versions 5 and 6.

3.5.2 - 2016-10-12
  * Explicitly support puppet-lint v2

3.5.1 - 2016-08-31
  * No changes, just another release to appease an issue with the Forge.

3.5.0 - 2016-08-31
  * Add support for Ruby v2.3.1

3.4.0 - 2015-05-27
  * Support Puppet v4 and v3 with future parser

3.0.4 - 2013-06-08 Garrett Honeycutt <code@garretthoneycutt.com>
* Fix warnings by using @ in front of variables in template
* .fixtures.yml is tracking correct version of puppetlabs/stdlib
* Drop Puppet v2.6 from travis-ci
* anders-larsson updates README to document support for SLES 10
* anders-larsson updates README to document support for all EL, not just CentOS

3.0.1 - 2013-03-16 Garrett Honeycutt <code@garretthoneycutt.com>
* fixed spec bug relating to lack of .fixtures.yml
* cleaned up testing framework

3.0.0 - 2013-03-16 Garrett Honeycutt <code@garretthoneycutt.com>
* Switched to semantic versioning - http://semver.org
* Implemented new design pattern that manages data with Hiera
* Truly portable module! Code is completely data driven, so you can make changes
  through Hiera and never have to edit the code itself.

2.0.0 - 2011-09-09 Garrett Honeycutt <garrett@puppetlabs.com>
* Implemented design pattern based on http://www.puppetlabs.com/blog/design-pattern-for-dealing-with-data/

1.0.1 - 2010-09-24 Garrett Honeycutt <code@garretthoneycutt.com>
* Added documentation

1.0.0 - 2010-06-24 Garrett Honeycutt <code@garretthoneycutt.com>
* Initial release
