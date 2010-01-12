require 'win32/ipc'

# The Win32 module serves as a namespace only.
module Win32

   # The Event class encapsulates Windows event objects.
   class Event < Ipc
   
      # This is the error raised if any of the Event methods fail.
      class Error < StandardError; end
      
      extend Windows::Synchronize
      extend Windows::Error
      extend Windows::Handle
      
      # The version of the win32-event library
      VERSION = '0.5.1'
   
      # The name of the Event object.
      #
      attr_reader :name
      
      # Indicates whether or not the Event requires use of the ResetEvent()
      # function set the state to nonsignaled.
      #
      attr_reader :manual_reset
      
      # The initial state of the Event object. If true, the initial state
      # is signaled. Otherwise, it is non-signaled.
      #
      attr_reader :initial_state
      
      # Creates and returns new Event object.  If +name+ is omitted, the
      # Event object is created without a name, i.e. it's anonymous.
      #
      # If +name+ is provided and it already exists, then it is opened
      # instead and the +manual_reset+ and +initial_state+ parameters are
      # ignored.
      #
      # If the +man_reset+ parameter is set to +true+, then it creates an Event
      # object which requires use of the Event#reset method in order to set the
      # state to non-signaled. If this parameter is false (the default) then
      # the system automatically resets the state to non-signaled after a
      # single waiting thread has been released.
      #
      # If the +init_state+ parameter is +true+, the initial state of the
      # Event object is signaled; otherwise, it is nonsignaled (the default).
      #
      # If the +inherit+ parameter is true, then processes created by this
      # process will inherit the handle. Otherwise they will not.
      # 
      # In block form this will automatically close the Event object at the
      # end of the block.
      # 
      def initialize(name=nil, man_reset=false, init_state=false, inherit=true)
         @name          = name
         @manual_reset  = man_reset
         @initial_state = init_state
         @inherit       = inherit
         
         manual_reset  = man_reset ? 1 : 0
         initial_state = init_state ? 1 : 0
         
         # Used to prevent potential segfaults.
         if name && !name.is_a?(String)
            raise TypeError, 'name must be a string'
         end

         if inherit
            sec = 0.chr * 12 # sizeof(SECURITY_ATTRIBUTES)
            sec[0,4] = [12].pack('L')
            sec[8,4] = [1].pack('L') # 1 == TRUE
         else
            sec = 0
         end
         
         handle = CreateEvent(sec, manual_reset, initial_state, name)
         
         if handle == 0 || handle == INVALID_HANDLE_VALUE
            raise Error, get_last_error
         end
 
         super(handle)
         
         if block_given?
            begin
               yield self
            ensure
               close
            end
         end
      end
      
      # Open an existing Event by +name+. The +inherit+ argument sets whether
      # or not the object was opened such that a process created by the
      # CreateProcess() function (a Windows API function) can inherit the
      # handle. The default is true.
      #
      # This method is essentially identical to Event.new, except that the
      # options for manual_reset and initial_state cannot be set (since they
      # are already set). Also, this method will raise an Event::Error if the
      # event doesn't already exist.
      #
      # If you want "open or create" semantics, then use Event.new.
      #
      def self.open(name, inherit=true, &block)
         if name && !name.is_a?(String)
            raise TypeError, 'name must be a string'
         end
         
         bool = inherit ? 1 : 0

         # This block of code is here strictly to force an error if the user
         # tries to open an event that doesn't already exist.
         begin
            handle = OpenEvent(EVENT_ALL_ACCESS, bool, name)

            if handle == 0 || handle == INVALID_HANDLE_VALUE
               raise Error, get_last_error
            end
         ensure
            CloseHandle(handle) if handle > 0
         end

         self.new(name, false, false, inherit, &block)
      end
      
      # Returns whether or not the object was opened such that a process
      # created by the CreateProcess() function (a Windows API function) can
      # inherit the handle. The default is true.
      #
      def inheritable?
         @inherit
      end
      
      # Sets the Event object to a non-signaled state.
      # 
      def reset
         unless ResetEvent(@handle)
            raise Error, get_last_error
         end
         @signaled = false
      end
      
      # Sets the Event object to a signaled state.
      # 
      def set
         unless SetEvent(@handle)
            raise Error, get_last_error
         end
         @signaled = true
      end
      
      # Synonym for Event#reset if +bool+ is false, or Event#set
      # if +bool+ is true.
      # 
      def signaled=(bool)
         if bool
            set
         else
            reset
         end
      end 
   end
end
