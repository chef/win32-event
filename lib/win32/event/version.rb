require "win32/ipc"

module Win32
  class Event < Ipc
    # The version of the win32-event library
    VERSION = "0.7.1".freeze
  end
end
