require "digest"

module Blockchain

  class Block
  
    def initialize(data : String)
      
      @data = data
      
    end

    def hash
    
    Digest::SHA256.hexdigest(@data)
    
    end

  end


end

puts Blockchain::Block.new("Hello World!").hash
