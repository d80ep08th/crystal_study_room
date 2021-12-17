require "digest"

module Blockchain

  class Block
  
    def initialize(data : String)
      
      @data = data
      
    end

    def hash

    hash = Digest::SHA256

    end

  end


end
