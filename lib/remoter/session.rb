require 'shellwords'

module Remoter
  class Session
    attr_reader :remoter
    attr_reader :target
    
    def initialize(_remoter, _target)
      @remoter = _remoter
      @target = _target
    end

    def scp(from, to)
      target_cmd = "scp -o StrictHostKeyChecking=no \"#{from}\" \"#{user_part}#{target.addr}:#{to.shellescape}\""
      raise SCPError, "The following command failed: #{target_cmd}" unless system(target_cmd)
    end
    
    def exe(cmd)
      target_cmd = "ssh #{user_part}#{target.addr} -o StrictHostKeyChecking=no \"#{cmd}\""
      raise EXEError, "The following command failed: #{target_cmd}" unless system(target_cmd)
    end
    
  private
  
    def user_part
      remoter.options['username'] ? "#{remoter.options['username']}@" : ''
    end
    
  end
end
