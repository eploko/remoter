module Remoter
  
  autoload :CLI,  'remoter/cli'
  autoload :UI,   'remoter/ui'

  class RemoterError < StandardError
    def self.status_code(code = nil)
      define_method(:status_code) { code }
    end
  end

end
