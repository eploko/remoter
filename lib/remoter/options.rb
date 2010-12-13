require 'optparse'
require 'ostruct'

require 'remoter/version'
  
module Remoter
  class Options
    
    #
    # Return a structure describing the options.
    #
    def self.parse(args)
      # The options specified on the command line will be collected in *options*.
      # We set default values here.
      options = OpenStruct.new
      options.verbose = false
      options.hosts = nil
      options.exclude_targets = nil
      options.ssh_port = 22
      options.number_of_workers = 5

      args.options do |opts| 
        opts.banner = "Usage: remoter [options]"
        opts.program_name = "remoter"
        opts.version = Remoter::Version::STRING
        
        opts.separator ""
        opts.separator "Required options:"
        
        opts.on("-t", "--task NAME", "Perform the given task") do |task|
          options.task = task
        end        

        opts.on("-h", "--hosts TARGETS", 
                "Can pass hostnames, IP addresses, networks, etc.", 
                "Ex: some.agent.org, ouragents.com/24, 192.168.0.1; 10.0.0-255.1-254") do |hosts|
          options.hosts = hosts
        end        

        opts.separator ""
        opts.separator "Optional stuff:"
        
        opts.on("--exclude TARGETS", "Exclude hosts/networks") do |exclude_targets|
          options.exclude_targets = exclude_targets
        end
        
        opts.on("-p", "--ssh-port PORT", Integer, "SSH port number to use", "Default is #{options.ssh_port}") do |port|
          options.ssh_port = port
        end
        
        opts.on("-w", "--workers N", Integer, "SSH port number to use", "Default is #{options.number_of_workers}") do |n|
          options.number_of_workers = n
        end
        
        opts.separator ""
        opts.separator "Common options:"

        opts.on("-v", "--[no-]verbose", "Run verbosely") do |v|
          options.verbose = v
        end

        opts.on_tail("-h", "--help", "Show this message") do
          puts opts
          exit
        end
        
        opts.on_tail("--version", "Show version") do
          puts "#{opts.program_name} #{opts.version}"
          exit
        end        

        begin
          opts.parse!(args)
        rescue => e
          puts e.message.capitalize + "\n\n"
          puts opts
          exit 1
        end        
        
        unless options.task
          puts 'Missing required argument --task or -t'
          puts opts
          exit 1
        end

        unless options.hosts
          puts 'Missing required argument --hosts or -h'
          puts opts
          exit 1
        end
      end

      options
    end
  end
end
