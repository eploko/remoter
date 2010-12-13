# encoding: utf-8

require 'thor'
require 'thor/actions'

require 'pp'
require 'nmap/parser'

require 'remoter/options'
require 'remoter/term_helpers'

module Remoter
  class CLI
        
    def self.start
      # puts "LOOKING FOR TARGETS..."
      # puts "FOUND TARGETS: #{hosts.count}"
      # hosts.each do |host|
      # end
    end
    
  private

    include Term::ANSIColor
    include TermHelpers

    def options
      @options ||= Options.parse(ARGV)  
    end
    
    def parser
      @parser ||= Nmap::Parser.parsescan('nmap', nmap_args)
    end

    def nmap_args
      result = "-sP #{options.hosts}"
      result += " --exclude #{options.exclude_targets}" if options.exclude_targets
      result
    end
    
    def hosts
      @hosts ||= parser.hosts('up')
    end
        
  end
end
