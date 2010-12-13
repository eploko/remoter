require 'term/ansicolor'

module Remoter
  module TermHelpers
    module ClassMethods
    end
  
    module InstanceMethods
      def exe(cmd) ; putcmd cmd ; system cmd ; end
      def putcmd(cmd) ; print magenta, "CMD: #{cmd}", reset, "\n" ; end
      def status(msg) ; print blue, "--- #{msg} ---", reset, "\n" ; end
      def success(msg) ; print green, bold, 'SUCCESS: ', msg, reset, "\n" ; end
      def error(msg) ; print red, bold, 'ERROR: ', msg, reset, "\n" ; exit 1 ; end
      def escape_cmd_args(args) ; args.collect{ |arg| "'#{arg}'"}.join(' ') ; end
    end
  
    def self.included(receiver)
      receiver.extend         ClassMethods
      receiver.send :include, InstanceMethods
    end
  end
end
