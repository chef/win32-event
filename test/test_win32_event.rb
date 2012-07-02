# encoding: UTF-8
#####################################################################
# test_win32_event.rb
#
# Test suite for the win32-event library. This test should be run
# via the 'rake test' task.
#####################################################################
require 'test-unit'
require 'test/unit'
require 'win32/event'
include Win32

class TC_Win32Event < Test::Unit::TestCase
  def setup
    @event   = nil
    @unicode = "Ηελλας"
    @ascii   = "foo"
  end

  def test_version
    assert_equal('0.6.0', Event::VERSION)
  end

  test "constructor works with no arguments" do
    assert_nothing_raised{ @event = Event.new }
  end

  test "constructor accepts an event name" do
    assert_nothing_raised{ @event = Event.new(@ascii) }
  end

  test "constructor accepts a unicode event name" do
    assert_nothing_raised{ @event = Event.new(@unicode) }
  end

=begin
  def test_constructor_errors
    assert_raises(ArgumentError){ Event.new("Foo", true, false, true, 1) }
    assert_raises(TypeError){ Event.new(1) }
  end

  def test_open
    assert_respond_to(Event, :open)
    assert_nothing_raised{ Event.open("Bar"){} }
    assert_nothing_raised{ Event.open("Ηελλας"){} }
    assert_nothing_raised{ Event.open("Bar", false) }
  end

  def test_open_expected_errors
    assert_raises(ArgumentError){ Event.open("Bar", true, false){} }
    assert_raises(Event::Error){ Event.open("Blah"){} }
    assert_raises(TypeError){ Event.open(1){} }
  end

  def test_inheritable
    @event1 = Event.open("Foo")
    @event2 = Event.open("Baz", false)

    assert_respond_to(@event1, :inheritable?)
    assert_nothing_raised{ @event1.inheritable? }
    assert_true(@event1.inheritable?)
    assert_false(@event2.inheritable?)
  end

  def test_name
    assert_respond_to(@event1, :name)
    assert_nothing_raised{ @event1.name }
    assert_nothing_raised{ @uni_event.name }
    assert_nil(@event1.name)
    assert_kind_of(String, @event2.name)
  end

  def test_initial_state
    assert_respond_to(@event1, :initial_state)
    assert_nothing_raised{ @event1.initial_state }

    assert_false(@event1.initial_state)
    assert_false(@event2.initial_state)
    assert_false(@event3.initial_state)
    assert_true(@event4.initial_state)
  end

  def test_manual_reset
    assert_respond_to(@event1, :manual_reset)
    assert_nothing_raised{ @event1.manual_reset }

    assert_false(@event1.manual_reset)
    assert_false(@event2.manual_reset)
    assert_true(@event3.manual_reset)
    assert_true(@event4.manual_reset)
  end

  def test_set
    assert_respond_to(@event1, :set)
    assert_nothing_raised{ @event1.set }
  end

  def test_is_signaled
    event = Event.new
    assert_respond_to(event, :signaled?)
    assert_nothing_raised{ event.signaled? }

    assert_false(event.signaled?)
    event.set
    assert_true(event.signaled?)
    event.reset
    assert_false(event.signaled?)
  end

  def test_reset
    assert_respond_to(@event1, :reset)
    assert_nothing_raised{ @event1.reset }
  end
=end

  test "close method basic functionality" do
    @event = Event.new
    assert_respond_to(@event, :close)
    assert_nothing_raised{ @event.close }
  end

  test "calling close multiple times has no effect" do
    @event = Event.new
    assert_nothing_raised{ 5.times{ @event.close } }
  end

  def teardown
    @event.close if @event
    @event = nil
  end
end
