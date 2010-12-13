# encoding: utf-8

require 'fileutils'
require 'term/ansicolor'

module Remoter
  class App
    include Term::ANSIColor

    def run
      banner
      check_args
      success "All done!"
    end

    def banner
      puts "Remoter v1.0.0"
      puts "(c) 2010 Andrey Subbotin <andrey@subbotin.me>"
    end

    def usage 
      puts ""
      puts "Usage: remoter [<task.remoter>]"
      puts ""
      puts "<task.remoter>   = remoter task file"   
    end

    def check_args 
      if (ARGV.length == 0)
        usage
        exit 1
      end
    end

    def exe(cmd)
      print magenta, "CMD: '#{cmd}'", reset, "\n"  
      system cmd
    end

    def status(msg)
      print blue, "--- #{msg} ---", reset, "\n"  
    end

    def error(msg)
      print red, bold, 'ERROR: ', msg, reset, "\n"
      exit 1
    end

    def success(msg)
      print green, bold, 'SUCCESS: ', msg, reset, "\n"
    end
  end
end
