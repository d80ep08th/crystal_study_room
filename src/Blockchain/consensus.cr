require "uri"
require "http/client"

module Blockchain
  module Consensus


    def register_node(address : String)
      uri = URI.parse(address)
      node_address = "#{uri.scheme}://#{uri.host}"
      node_address = "#{node_address}:#{uri.port}" unless uri.port.nil?
      @nodes.add(node_address)
    rescue
      raise "Invalid URL"
    end

    def resolve
      updated = false

      j = 0
      @nodes.each do |node|
        j = j + 1
        node_chain = parse_chain(node)
        return unless [node_chain].size > [@chain].size
        return unless valid_chain?(node_chain)
        #@chain = node_chain[j]
        @chain = node_chain
        updated = true
      rescue IO::TimeoutError
        puts "Timeout!"
      end

      updated
    end

    private def parse_chain(node : String)
      node_url = URI.parse("#{node}/chain")
      node_chain = HTTP::Client.get(node_url)
      #puts node_chain
      node_chain = JSON.parse(node_chain.body)["chain"].to_json
      #puts node_chain
      Blockchain::Block.from_json(node_chain)

    end

    private def valid_chain?(node_chain)
      previous_hash = "0"
      i = 0
      [node_chain].each do |block|
        i = i + 1
        #current_block_hash = block.current_hash
        #block.recalculate_hash
        current_block_hash = block.recalculate_hash

        return false if current_block_hash != block.recalculate_hash # current_hash
        return false if previous_hash != block.prev_hash
        return false if current_block_hash[0..1] != "00"
        previous_hash = block.recalculate_hash
      end

      return true
    end
  end
end
