require "json"

module Blockchain
  class Block
    class Transaction

      include JSON::Serializable

      #@from =  String.new
      #@to = String.new
      #@amount = Int64.new "0"
      getter from : String
      getter to : String
      getter amount : Int64

      def initialize(@from, @to, @amount : Int64 )
      end

    end
  end
end
