require "./block"
require "./transaction"
require "./consensus"

module Blockchain
  class Blocked
    include Consensus

    BLOCK_SIZE = 25

    getter chain : Blockchain::Block # Array.new of Int32 #Set(String)
    getter uncommitted_transactions : Block::Transaction
    getter nodes : Set(String)

    def initialize

      @chain = Blockchain::Block.new
      @uncommitted_transactions = Block::Transaction.new(from: "", to: "", amount: 0)
      @nodes =  Set(String).new [] of String
    end

    def add_transaction(transaction)
      p @uncommitted_transactions
      #@uncommitted_transactions << transaction
    end

    def mine
       raise "No transactions to be mined" if  [@uncommitted_transactions].empty?#@uncommitted_transactions.empty?


       new_block = Block.next(
         previous_block: @chain,
         transactions: [@uncommitted_transactions].shift(BLOCK_SIZE)
       )


       [@chain] << new_block
    end
  end
end
