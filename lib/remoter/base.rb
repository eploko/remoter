# encoding: utf-8

require 'thor'
require 'nmap/parser'

module Remoter
  class Base < Thor
    
    def initialize(*)
      super
      the_shell = (options["no-color"] ? Thor::Shell::Basic.new : shell)
      Remoter.ui = UI::Shell.new(the_shell)
      Remoter.ui.debug! if options["verbose"]
    end

    class_option "no-color", :type => :boolean, :desc => "Disable colorization in output"
    class_option "verbose",  :type => :boolean, :desc => "Enable verbose output mode", :aliases => "-v"
    class_option "workers",  :type => :numeric, :desc => "Number of parallel SSH sessions", :aliases => "-w", :default => 5
    class_option "username",  :type => :string, :desc => "Username to use for the SSH sessions", :aliases => "-u"

    protected
    
      def self.beam(name, &block)
        self.send :method_option, "targets", :type => :array, :alias => "-t", :required => true, :desc => 
          "Can pass hostnames, IP addresses, networks, etc. Ex: some.agent.org, ouragents.com/24, 192.168.0.1; 10.0.0-255.1-254"
        self.send :method_option, "exclude", :type => :array, :desc => 
          "Exclude hosts/networks."
        define_method name do
          workers = []
          items_per_worker = (hosts.count.to_f / options['workers'].to_f).ceil
          hosts.each_slice(items_per_worker).to_a.each_with_index do |targets, worker_no|
            Remoter.ui.debug "WORKER ##{worker_no}: #{targets.count}"
            workers << Process.fork do 
              Remoter.ui.debug "WORKER ##{worker_no}: Proceeding with #{targets.count} agents..."      
              while (target = targets.shift)
                Remoter.ui.debug "WORKER ##{worker_no}: PROCESSING #{target.addr}..."
                begin
                  send Base.body_method_name(name), Session.new(self, target)
                rescue RemoterError => error
                  Remoter.ui.error "WORKER ##{worker_no}: ERROR: #{error.message}"
                  Remoter.ui.error "WORKER ##{worker_no}: FAILED for #{target.addr}... WILL RETRY"
                  targets.push target
                else
                  Remoter.ui.confirm "WORKER ##{worker_no}: SUCEEDED for #{target.addr}"
                end
              end
            end
          end
          workers.each { |pid| Process.wait(pid) }
          Remoter.ui.confirm "ALL DONE. KEWL."
        end
        no_tasks do
          define_method body_method_name(name), block
        end
      end
      
      def parser
        @parser ||= Nmap::Parser.parsescan('nmap', nmap_args)
      end
  
      def nmap_args
        result = "-sP"
        result += " --exclude #{options['exclude'].join(',')}" if options['exclude']
        result += " #{options['targets'].join(' ')}"
        result
      end
    
      def hosts
        @hosts ||= parser.hosts('up')
      end
      
    private
      
      def self.body_method_name(beam_name) ; "#{beam_name.to_s}_body".to_sym ; end
        
  end
end
