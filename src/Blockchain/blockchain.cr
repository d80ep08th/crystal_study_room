require "./block"
require "./transaction"
require "./consensus"

module Blockchain
  class Blocked
    include Consensus

    BLOCK_SIZE = 25

    getter chain : Blockchain::Block #Array(String)#Blockchain::Block # Array.new of Int32 #Set(String)
    getter uncommitted_transactions : Block::Transaction#Array(String) #Block::Transaction
    getter nodes : Set(String)

    def initialize

      @chain = Blockchain::Block.new #[Blockchain::Block.new.to_s]
      @uncommitted_transactions =  Block::Transaction.new(from: "", to: "", amount: 0) #[Block::Transaction.new(from: "", to: "", amount: 0).to_s]
      @nodes =  Set(String).new [] of String
    end

    def add_transaction(transaction)
      #p "From #{uncommitted_transactions.from}, To #{uncommitted_transactions.to}, Amount#{uncommitted_transactions.amount} and Transaction#{transaction.from} #{transaction.to} #{transaction.amount}"
      #@uncommitted_transactions
      uncommitted_transactions = transaction
      #p "uncommitted_transactions #{ [uncommitted_transactions]} "
      #p "UC TRANSACT From #{uncommitted_transactions.from}, To #{uncommitted_transactions.to}, Amount#{uncommitted_transactions.amount}"
    end

    def mine
       p "chain #{ [chain]} "
       p "uncommitted_transactions #{ [uncommitted_transactions]} "
       p "nodes #{ nodes}"
       raise "No transactions to be mined" if  [@uncommitted_transactions].empty?#@uncommitted_transactions.empty?

       p "before uncommitted_transactions mined#{ [uncommitted_transactions]} "
       new_block = Block.next(
         previous_block: @chain,
         transactions: [@uncommitted_transactions].shift(BLOCK_SIZE)
       )

       p "New Block #{new_block}after uncommitted_transactions mined #{ [uncommitted_transactions]} "
       #@chain << [new_block]
       chain = new_block
    end
  end
end
