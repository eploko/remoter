# encoding: utf-8

require 'pp'

require 'remoter/options'
require 'remoter/term_helpers'

module Remoter
  class App
    include Term::ANSIColor
    include TermHelpers
    
    def run
      Options.parse(ARGV)
      pp ARGV.options
    end
  end
end
