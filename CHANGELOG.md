# win32-event Changelog

<!-- latest_release 0.6.3 -->
<!-- latest_release -->

<!-- release_rollup -->
<!-- release_rollup -->

<!-- latest_stable_release -->
<!-- latest_stable_release -->

## Previous Release

== 0.6.3 - 25-Oct-2015
* Added a win32-event.rb file for convenience.

== 0.6.2 - 24-Oct-2015
* Change most bools to ints. This required explicitly defining some
  attribute reader methods as well.
* The gem is now signed.
* Cleanup and updates for the Rakefile and gemspec.

== 0.6.1 - 9-Apr-2013
* Fixed the HANDLE datatypes in the underlying FFI code. This addresses
  an issue for 64 bit versions of Ruby.

== 0.6.0 - 9-Jul-2012
* Converted code to use FFI.
* Now requires Ruby 1.9 or later.
* Updated and refactored tests.

== 0.5.2 - 21-Apr-2010
* Updated the gemspec, adding some gem building tasks, and removed the
  inline gem building code from the gemspec itself.
* Added test-unit 2 as a development dependency and made some minor
  updates to the test suite.

== 0.5.1 - 6-Aug-2009
* License changed to Artistic 2.0.
* Some gemspec updates, including the addition of a license and an update
  to the description.
* The Event.open method is now slightly more robust.
* Renamed the test file to test_win32_event.rb.

== 0.5.0 - 3-May-2007
* Now pure Ruby.
* Both the Event.new and Event.open methods now accept a block, and
  automatically close the associated handle at the end of the block.
* The Event.new method now accepts an optional fourth argument that controls
  whether the Event object can be inherited by other processes.
* Added a gemspec.
* Added a Rakefile, including tasks for installation and testing.
* Removed the doc/event.txt file. The documentation is now inlined via RDoc.
  There is also some documentation in the README file.
* Now requires the windows-pr package.

== 0.4.0 - 28-May-2005
* All methods now return self or klass (instead of true).
* Added the Event#inheritable? attribute that stores whether or not the Event
  object is inheritable with regards to CreateProcess().
* The Event#set and Event#unset now properly set the Event#signaled? value.
* More Unicode friendly.
* Removed the event.rd file.  The event.txt file is now rdoc friendly.
* Code cleanup.

== 0.3.1 - 1-Mar-2005
* Moved the 'examples' directory to the toplevel directory.
* Made the CHANGES and README files rdoc friendly.

== 0.3.0 - 17-Jul-2004
* Now uses the newer allocation framework, as well as replace the deprecated
  STR2CSTR() function with StringValuePtr().  This means that, as of this
  release, Ruby 1.8.0 or later is required.
* Removed the .html file as part of the distro.  You can generate this on your
  own via rd2.
* Moved the test.rb script to doc/examples.

== 0.2.0 - 28-Apr-2004
* The Event class is now a subclass of Ipc (and thus requires the win32-ipc
  package).
* Documentation updates

== 0.1.0 - 12-Jan-2004
- Initial release.
