require "json"

module Blockchain
  class Block
    class Transaction

      include JSON::Serializable

      @from =  String.new
      @to = String.new
      @amount = Int32.new "0"


      def initialize(@from, @to, @amount)
      end

    end
  end
end
