require "./proof_of_work"
require "./transaction"

module Blockchain
  class Block
    include ProofOfWork
    include JSON::Serializable

    @index = Int32.new "0"
    @current_hash = String.new
    @nonce = Int32.new "0"
    @previous_hash = String.new
    #@transactions = Array(Transaction).new
    @transactions = Int32.new "0"#typeof(Transaction)
    @timestamp = Time.local


    def initialize(index = 0, transactions = [] of Transaction, previous_hash = "hash")
      @transactions =  0 #transactions
      @index = index
      @timestamp = Time.utc
      @previous_hash = previous_hash
      @nonce = proof_of_work
      @current_hash = calc_hash_with_nonce(@nonce)
    end

    def self.first
      Block.new(previous_hash: "0")
    end

    def self.next(previous_block, transactions = [] of Transaction)
      Block.new(
        transactions: transactions,
        index: [previous_block].size + 1,
        previous_hash: previous_block.to_s
      )
    end

    def recalculate_hash : String
      @nonce = proof_of_work
      @current_hash = calc_hash_with_nonce(@nonce)
    end

    def prev_hash : String
      @previous_hash
    end
  end
end


blockchain = [ Blockchain::Block.first ]
puts blockchain
