# encoding: utf-8

require 'thor'
require 'thor/actions'

require 'pp'
require 'nmap/parser'

require 'remoter/options'
require 'remoter/term_helpers'

module Remoter
  class CLI < Thor
    
    include Thor::Actions

    def initialize(*)
      super
      the_shell = (options["no-color"] ? Thor::Shell::Basic.new : shell)
      Remoter.ui = UI::Shell.new(the_shell)
      Remoter.ui.debug! if options["verbose"]
      load_beams
    end

    class_option "no-color", :type => :boolean, :desc => "Disable colorization in output"
    class_option "verbose",  :type => :boolean, :desc => "Enable verbose output mode", :aliases => "-v"
    class_option "targets", :type => :array, :alias => "-t", :desc => 
      "Can pass hostnames, IP addresses, networks, etc. Ex: some.agent.org, ouragents.com/24, 192.168.0.1; 10.0.0-255.1-254"
    class_option "exclude", :type => :array, :desc =>
      "Exclude hosts/networks."

    private
    
      def load_beams
        glob("beams/*.beam") do |name|
          class_eval Remoter.read_file(name), name
        end
      end
    
      def glob(path, &block)
        Dir[path.gsub("\\", '/')].each(&block)
      end
              
  #   def self.start
  #     # puts "LOOKING FOR TARGETS..."
  #     # puts "FOUND TARGETS: #{hosts.count}"
  #     # hosts.each do |host|
  #     # end
  #   end
  #   
  # private
  # 
  #   include Term::ANSIColor
  #   include TermHelpers
  # 
  #   def options
  #     @options ||= Options.parse(ARGV)  
  #   end
  #   
  #   def parser
  #     @parser ||= Nmap::Parser.parsescan('nmap', nmap_args)
  #   end
  # 
  #   def nmap_args
  #     result = "-sP #{options.hosts}"
  #     result += " --exclude #{options.exclude_targets}" if options.exclude_targets
  #     result
  #   end
  #   
  #   def hosts
  #     @hosts ||= parser.hosts('up')
  #   end
        
  end
end
