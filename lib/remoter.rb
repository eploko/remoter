module Remoter
  
  autoload :Base,       'remoter/base'
  autoload :Session,    'remoter/session'  
  autoload :UI,         'remoter/ui'

  class RemoterError < StandardError
    def self.status_code(code = nil)
      define_method(:status_code) { code }
    end
  end
  
  class SCPError < RemoterError; status_code(10); end
  class EXEError < RemoterError; status_code(11); end
  
  class << self
    attr_writer :ui

    def ui
      @ui ||= UI.new
    end

    def read_file(file)
      File.open(file, "rb") { |f| f.read }
    end
  end

end
