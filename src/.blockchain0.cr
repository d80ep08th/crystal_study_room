require "digest"
require "./pow"

module Blockchain

  class Block
    include ProofOfWork

    property current_hash = String.new
    property index = Int32.new "0"
    property nonce = Int32.new "0"
    property previous_hash = String.new

    def initialize(index = 0, data = "data", previous_hash = "hash")
      @data = data
      @index = index
      @timestamp = Time.local
      @previous_hash = previous_hash
      @current_hash = hash_block
      @nonce = proof_of_work
      #@current_hash = calc_hash_with_nonce(@nonce)
    end

    def self.first(index = 0, data="Genesis Block")
      Block.new(index: index, data: data, previous_hash: "0")
    end

    def self.next(previous_node, data = " " )
      Block.new(
        index: previous_node.size,
        data: "Transaction data number (#{previous_node.size})",
        previous_hash: previous_node.current_hash.to_s
      )
    end

    #def hash_block
    #  Digest::SHA256.hexdigest("#{@index}#{@timestamp}#{@data}#{@previous_hash}")
    #end

  end


end


blockchain = [ Blockchain::Block.first ]
previous_block = blockchain

5.times do
  new_block = Blockchain::Block.next(previous_block)
  blockchain << new_block
  previous_block = blockchain
end

p blockchain
