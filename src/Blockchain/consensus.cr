require "uri"
require "http/client"
require "json"

module Blockchain
  module Consensus


    def register_node(address : String)
      uri = URI.parse(address)
      node_address = "#{uri.scheme}://#{uri.host}"
      node_address = "#{node_address}:#{uri.port}" unless uri.port.nil?
      @nodes.add(node_address)
      p " Nodes = > #{@nodes}"
    rescue
      raise "Invalid URL"
    end

    def resolve
      updated = false

      j = 0
      p "RESOLVE"
      p " nodes = > #{@nodes}"
      @nodes.each do |node|
        j = j + 1

        p " node = > #{node}"
        #node_chain = parse_chain(node.to_s)
        node_chain = parse_chain(node)
        p " PARSED NODE CHAIN = > #{node_chain}"
        p "_________________________________________________________________________________________________________________________"

        return unless node_chain.size > @chain.size
        return unless valid_chain?(node_chain)
        #@chain = node_chain[j]
        #node_chain.each do |block|
        #  @chain.add(block)
        #emd
        node_chain.each do |block|
          @chain.add(block)
        end
        updated = true
        rescue IO::TimeoutError
        puts "Timeout!"
      end

      updated
    end

    private def parse_chain(node : String)
      p " PARSE CHAIN"
      node_url = URI.parse("#{node}/chain")
      p " node_url = > #{node_url}"
      node_chain = HTTP::Client.get(node_url)
      p " GET NODE_CHAIN FROM NODE_URL = >  "
      p  node_chain
      p "AND ITS TYPE #{typeof(node_chain)}"
      p "_________________________________________________________________________________________________________________________"
      #node_chain = JSON.parse(node_chain.body)["chain"].to_json
      node_chain = JSON.parse(node_chain.body)

      p " NODE_CHAIN JSON BODY  = > #{node_chain}"
      p " node_chain = > #{typeof(node_chain)}"
      p "_________________________________________________________________________________________________________________________"
      p " NODE_CHAIN JSON BODY CHAIN to_json = > #{node_chain["chain"].to_json}"
      node_chain = node_chain["chain"].to_json
      p " TYPE OF NODE_CHAIN JSON BODY CHAIN to_json = > #{typeof(node_chain)}"
      p "_________________________________________________________________________________________________________________________"
      p " Array(Blockchain::Block) TYPE OF NODE_CHAIN JSON BODY CHAIN to_json = > #{Array(Blockchain::Block).from_json(node_chain)}"
      p "_________________________________________________________________________________________________________________________"

      #p " Set(Blockchain::Block) TYPE OF NODE_CHAIN JSON BODY CHAIN to_json = > #{Set(Blockchain::Block).from_json(node_chain)}"
      p "_________________________________________________________________________________________________________________________"

      p "_________________________________________________________________________________________________________________________"

        #p "seeing if it works"
      p "_________________________________________________________________________________________________________________________"
      #p " NODE_CHAIN JSON BODY CHAIN  1 = > #{node_chain["chain"][0]}"
      #p "_________________________________________________________________________________________________________________________"
      #p " NODE_CHAIN JSON BODY CHAIN  = > #{node_chain["chain"][]}"

      #Array(Blockchain::Block).from_json(node_chain.to_json)
      #Array(Blockchain::Block).from_json(node_chain)
      node_chain = Array(Blockchain::Block).from_json(node_chain)
      node_chain
      #p "__END_______________________________________________________________________________________________________________"

    end

    private def valid_chain?(node_chain)
      p " VALID CHAIN ?"
      p "_________________________________________________________________________________________________________________________"

      p " NODE_CHAIN  = > #{node_chain}"
      p "_________________________________________________________________________________________________________________________"
      p " NODE_CHAIN SIZE  = > #{node_chain.size}"
      p "_________________________________________________________________________________________________________________________"
      p " NODE1  = > #{[node_chain[0]]}"
      p "_________________________________________________________________________________________________________________________"
      p " NODE2   = > #{[node_chain[1]]}"
      p "_________________________________________________________________________________________________________________________"

      previous_hash = "0"
      i = 0
      node_chain.each do |block|

        i = i + 1

        p "__________________________________________________________________________________________"
        p "  EACH NODE_CHAIN BLOCK #{i} : #{[block]}"
        p "  BLOCK #{i} index : #{block.@index}"
        p "  BLOCK #{i} current_hash: #{block.@current_hash}"
        p "  BLOCK #{i} nonce : #{block.@nonce}"
        p "  BLOCK #{i} previous_hash: #{block.@previous_hash}"
        p "  BLOCK #{i} transactions: #{block.@transactions}"
        p "  BLOCK #{i} timestamp: #{block.@timestamp}"

        p "__________________________________________________________________________________________"
      end
      m = 0
      node_chain.each do |block|
        m = m + 1

        p "__________________________________________________________________________________________"
        p "  BLOCK #{m} current_hash: #{block.@current_hash}"

        p "__________________________________________________________________________________________"
        current_block_hash = block.@current_hash
        p "  current_block_hash: #{current_block_hash}"

        p "__________________________________________________________________________________________"
        recalculated_block = block.recalculate_hash

        #p "  recalculate_hash.@nonce: #{block.recalculate_hash.@nonce}"
        #p "  recalculate_hash.@current_hash: #{block.recalculate_hash.@current_hash}"
        p "__________________________________________________________________________________________"
        p "  recalculated_block: #{recalculated_block}"
        p "  recalculate_hash: #{block.recalculate_hash}"
        p "__________________________________________________________________________________________"
        p "  current_block_hash != block.@current_hash: #{current_block_hash != block.@current_hash}"
        p "__________________________________________________________________________________________"
        p "  previous_hash != block.@previous_hash: #{previous_hash != block.@previous_hash}"
        p "__________________________________________________________________________________________"
        return false if current_block_hash != block.@current_hash
        return false if previous_hash == block.@previous_hash
        return false if current_block_hash[0..1] != "00"
        previous_hash = block.recalculate_hash
      end

      return true
    end
  end
end
