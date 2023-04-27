#####################################################################
# test_win32_event.rb
#
# Test suite for the win32-event library. This test should be run
# via the 'rake test' task.
#####################################################################
require "test-unit"
require "test/unit"
require "win32/event"
include Win32

class TC_Win32Event < Test::Unit::TestCase
  def setup
    @event   = Event.new
    @unicode = "Ηελλας"
    @ascii   = "foo"
  end

  test "version is set to expected value" do
    assert_equal("0.6.3", Event::VERSION)
  end

  test "constructor works with no arguments" do
    assert_nothing_raised { @event = Event.new }
    assert_nil(@event.name)
  end

  test "constructor accepts an event name" do
    assert_nothing_raised { @event = Event.new(@ascii) }
  end

  test "constructor accepts a unicode event name" do
    assert_nothing_raised { @event = Event.new(@unicode) }
  end

  test "constructor accepts a block" do
    assert_nothing_raised {
      # anonymous event object, with manual-reset, initial state signaled!
      event = Event.new nil, true, true do |ev|
        assert_true(ev.signaled?)
        ev.reset
        # 'event'/'ev' object has closed automatically
      end
      # Errno::ENXIO(<No such device or address - WaitForSingleObject>)
      assert_raise(Errno::ENXIO) { event.signaled? }
    }
  end

  test "constructor accepts a maximum of four arguments" do
    assert_raises(ArgumentError) { Event.new("Foo", true, false, true, 1) }
  end

  test "first argument to constructor must be a string" do
    assert_raise(TypeError) { Event.new(1) }
  end

  test "open method basic functionality" do
    event = Event.new(@ascii)
    assert_respond_to(Event, :open)
    assert_nothing_raised { @event = Event.open(@ascii) }
    assert_equal(@ascii, @event.name)
    event.close
  end

  test "open method accepts an inherit argument" do
    event = Event.new(@ascii)
    assert_nothing_raised { @event = Event.open(@ascii, false) }
    assert_false(@event.inheritable?)
    event.close
  end

  test "open method works with unicode names" do
    event = Event.new(@unicode)
    assert_nothing_raised { @event = Event.open(@unicode) }
    assert_equal(@unicode, @event.name)
    event.close
  end

  test "open method requires a name" do
    assert_raise(ArgumentError) { Event.open }
  end

  test "open method requires a string argument as the first argument" do
    assert_raises(TypeError) { Event.open(1) {} }
  end

  test "open accepts a maximum of two arguments" do
    assert_raise(ArgumentError) { Event.open("bogus", true, false) }
  end

  test "open method fails if name cannot be found" do
    assert_raise(Errno::ENOENT) { Event.open("bogus") }
  end

  test "inheritable basic functionality" do
    assert_respond_to(@event, :inheritable?)
    assert_nothing_raised { @event.inheritable? }
  end

  test "inheritable is true by default" do
    assert_true(@event.inheritable?)
  end

  test "inheritable matches value passed to constructor" do
    @event = Event.new(nil, false, false, false)
    assert_false(@event.inheritable?)
  end

  test "name attribute basic functionality" do
    assert_respond_to(@event, :name)
    assert_nothing_raised { @event.name }
  end

  test "name is nil by default" do
    assert_nil(@event.name)
  end

  test "name is set to value specified in constructor" do
    @event = Event.new(@ascii)
    assert_equal(@ascii, @event.name)
  end

  test "name is set to unicode value specified in constructor" do
    @event = Event.new(@unicode)
    assert_equal(@unicode, @event.name)
  end

  test "initial_state basic functionality" do
    assert_respond_to(@event, :initial_state)
    assert_nothing_raised { @event.initial_state }
    assert_boolean(@event.initial_state)
  end

  test "initial_state is false by default" do
    assert_false(@event.initial_state)
  end

  test "initial state matches value set in constructor" do
    @event = Event.new(nil, false, true)
    assert_true(@event.initial_state)
  end

  test "manual_reset basic functionality" do
    assert_respond_to(@event, :manual_reset)
    assert_nothing_raised { @event.manual_reset }
    assert_boolean(@event.manual_reset)
  end

  test "manual_reset is false by default" do
    assert_false(@event.manual_reset)
  end

  test "manual reset matches value passed to constructor" do
    event = Event.new(nil, true)
    assert_true(event.manual_reset)
    event.close
  end

  test "signaled? basic functionality" do
    assert_respond_to(@event, :signaled?)
    assert_nothing_raised { @event.signaled? }
  end

  test "signaled? returns a boolean" do
    assert_boolean(@event.signaled?)
  end

  test "set basic functionality" do
    @event = Event.new
    assert_respond_to(@event, :set)
    assert_nothing_raised { @event.set }
  end

  test "set puts event in signaled state" do
    assert_false(@event.signaled?)
    @event.set
    assert_true(@event.signaled?)
  end

  test "reset basic functionality" do
    assert_respond_to(@event, :reset)
    assert_nothing_raised { @event.reset }
  end

  test "reset sets signaled state to false" do
    @event.set
    assert_true(@event.signaled?)
    @event.reset
    assert_false(@event.signaled?)
  end

  test "close method basic functionality" do
    assert_respond_to(@event, :close)
    assert_nothing_raised { @event.close }
  end

  test "calling close multiple times has no effect" do
    assert_nothing_raised { 5.times { @event.close } }
  end

  test "ffi functions are private" do
    assert_not_respond_to(Event, :CreateEvent)
    assert_not_respond_to(Event, :OpenEvent)
    assert_not_respond_to(Event, :SetEvent)
    assert_not_respond_to(Event, :ResetEvent)
  end

  def teardown
    @event.close if @event
    @event = nil
  end
end
