require "kemal"
require "uuid"

require "./Blockchain/blockchain"

before_all do |env|
  env.response.content_type = "application/json"
end

blockchain = Blockchain::Blocked.new

# Generate a globally unique address for this node
node_identifier = UUID.random.to_s

get "/" do
  "Hello World!"
end

get "/chain" do
  { chain: blockchain.chain }.to_json
end

get "/mine" do
  p "Block before mining #{[blockchain.chain]} "
  blockchain.mine
  p "Block with index=#{[blockchain.chain].size} is mined."
  p "Block after mining #{[blockchain.chain]} "
end

get "/pendings" do
  { transactions: blockchain.uncommitted_transactions }.to_json
end

post "/transactions/new" do |env|
  transaction = Blockchain::Block::Transaction.new(
    from: env.params.json["from"].as(String),
    to:  env.params.json["to"].as(String),
    amount:  env.params.json["amount"].as(Int64)
  )

  blockchain.add_transaction(transaction)

  p "Blockchain #{blockchain.chain} ."
  p "Transaction #{transaction} has been added to the node"
  p "ADDED FROM #{transaction.from} , TO #{transaction.to} , Amount #{transaction.amount} "
end

post "/nodes/register" do |env|
  nodes = env.params.json["nodes"].as(Array)

  raise "Empty array" if nodes.empty?

  nodes.each do |node|
    blockchain.register_node(node.to_s)
  end

  "New nodes have been added: #{blockchain.nodes}"
end

get "/nodes/resolve" do
  if blockchain.resolve
    "Succefully updated the chain"
  else
    "Current chain is up-to-dated"
  end
end

Kemal.run
