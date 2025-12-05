# Crystal Blockchain Study Room

> A blockchain implementation in Crystal language with RESTful APIs for learning blockchain concepts.

## 📚 About

This project is a learning resource for understanding blockchain technology through hands-on API interactions. Built with Crystal and Kemal, it provides a complete blockchain implementation with mining, transactions, and consensus mechanisms.

## 🚀 Getting Started

### Prerequisites

- Crystal 1.2.2 or higher ([Installation Guide](https://crystal-lang.org/install/))
- Git

### Installation

1. **Clone the repository:**
```bash
   git clone https://github.com/d80ep08th/crystal_study_room.git
   cd crystal_study_room
```

2. **Switch to the blockchain branch:**
```bash
   git checkout blockchain
```

3. **Install dependencies:**
```bash
   shards install
```

4. **Run the server:**
```bash
   crystal run src/server.cr
```

   The server will start on `http://localhost:3000`

## 📖 API Documentation

### 1. View the Blockchain

**Endpoint:** `GET /chain`

**Description:** Returns the entire blockchain with all mined blocks.

**Example:**
```bash
curl http://localhost:3000/chain
```

**Response:**
```json
{
  "chain": [
    {
      "index": 0,
      "current_hash": "00abc...",
      "nonce": 12345,
      "previous_hash": "0",
      "transactions": [],
      "timestamp": "2024-01-01T12:00:00Z"
    }
  ]
}
```

### 2. Create a New Transaction

**Endpoint:** `POST /transactions/new`

**Description:** Add a new transaction to the pool of uncommitted transactions.

**Example:**
```bash
curl -X POST http://localhost:3000/transactions/new \
  -H "Content-Type: application/json" \
  -d '{
    "from": "Alice",
    "to": "Bob",
    "amount": 50
  }'
```

**Parameters:**
- `from` (string): Sender's address
- `to` (string): Recipient's address
- `amount` (integer): Amount to transfer

### 3. Mine a New Block

**Endpoint:** `GET /mine`

**Description:** Mines a new block containing pending transactions using Proof of Work.

**Example:**
```bash
curl http://localhost:3000/mine
```

**Note:** This will mine up to 25 transactions per block (configurable in `BLOCK_SIZE`).

### 4. View Pending Transactions

**Endpoint:** `GET /pendings`

**Description:** Returns all uncommitted transactions waiting to be mined.

**Example:**
```bash
curl http://localhost:3000/pendings
```

**Response:**
```json
{
  "transactions": [
    {
      "from": "Alice",
      "to": "Bob",
      "amount": 50
    }
  ]
}
```

### 5. Register Network Nodes

**Endpoint:** `POST /nodes/register`

**Description:** Register other blockchain nodes for consensus.

**Example:**
```bash
curl -X POST http://localhost:3000/nodes/register \
  -H "Content-Type: application/json" \
  -d '{
    "nodes": [
      "http://localhost:3001",
      "http://localhost:3002"
    ]
  }'
```

### 6. Resolve Conflicts (Consensus)

**Endpoint:** `GET /nodes/resolve`

**Description:** Implements consensus algorithm to replace chain with longest valid chain in the network.

**Example:**
```bash
curl http://localhost:3000/nodes/resolve
```

**Response:**
- "Successfully updated the chain" - Chain was replaced
- "Current chain is up-to-date" - No changes needed

## 🎓 Learning Exercises

### Exercise 1: Create Your First Transaction
```bash
# Start the server
crystal run src/server.cr

# In another terminal, create a transaction
curl -X POST http://localhost:3000/transactions/new \
  -H "Content-Type: application/json" \
  -d '{"from": "Student1", "to": "Student2", "amount": 100}'

# View pending transactions
curl http://localhost:3000/pendings
```

### Exercise 2: Mine a Block
```bash
# Mine the pending transactions
curl http://localhost:3000/mine

# View the updated blockchain
curl http://localhost:3000/chain
```

### Exercise 3: Create Multiple Transactions and Mine
```bash
# Create several transactions
for i in {1..5}; do
  curl -X POST http://localhost:3000/transactions/new \
    -H "Content-Type: application/json" \
    -d "{\"from\": \"User$i\", \"to\": \"User$((i+1))\", \"amount\": $((i*10))}"
done

# Check pending transactions
curl http://localhost:3000/pendings

# Mine them into a block
curl http://localhost:3000/mine

# Verify the blockchain
curl http://localhost:3000/chain
```

### Exercise 4: Simulate a Distributed Network
```bash
# Terminal 1: Start first node
PORT=3000 crystal run src/server.cr

# Terminal 2: Start second node
PORT=3001 crystal run src/server.cr

# Terminal 3: Register nodes with each other
curl -X POST http://localhost:3000/nodes/register \
  -H "Content-Type: application/json" \
  -d '{"nodes": ["http://localhost:3001"]}'

# Create transactions on first node
curl -X POST http://localhost:3000/transactions/new \
  -H "Content-Type: application/json" \
  -d '{"from": "Node1", "to": "Node2", "amount": 25}'

# Mine on first node
curl http://localhost:3000/mine

# Resolve consensus on second node
curl http://localhost:3001/nodes/resolve
```

## 🔧 Project Structure
```
crystal_study_room/
├── src/
│   ├── blockchain.cr          # Main module
│   ├── server.cr              # Kemal web server
│   └── Blockchain/
│       ├── block.cr           # Block implementation
│       ├── blockchain.cr      # Blockchain management
│       ├── transaction.cr     # Transaction structure
│       ├── proof_of_work.cr   # PoW algorithm
│       └── consensus.cr       # Consensus mechanism
├── spec/                      # Tests
├── lib/                       # Dependencies
└── shard.yml                  # Project configuration
```

## 🧪 Running Tests
```bash
crystal spec
```

## 🔍 Key Blockchain Concepts Demonstrated

### 1. **Proof of Work (PoW)**
- Located in `src/Blockchain/proof_of_work.cr`
- Difficulty: Hash must start with "00"
- Demonstrates computational puzzle solving

### 2. **Block Structure**
- Index: Block position in chain
- Timestamp: When block was created
- Transactions: List of transactions
- Previous Hash: Link to previous block
- Nonce: Number used once for PoW
- Current Hash: SHA256 hash of block data

### 3. **Consensus Algorithm**
- Longest valid chain wins
- Validates entire chain before accepting
- Checks hash integrity and PoW

### 4. **Transaction Pool**
- Uncommitted transactions wait in pool
- Mining adds them to blockchain
- Configurable block size (default: 25 transactions)

## 🐛 Troubleshooting

### Issue: Server won't start
```bash
# Make sure you're on the blockchain branch
git checkout blockchain

# Reinstall dependencies
rm -rf lib/ .shards/
shards install

# Try running again
crystal run src/server.cr
```

### Issue: Port already in use
```bash
# Change the port
PORT=3001 crystal run src/server.cr
```

### Issue: Dependencies error
```bash
# Update shards
shards update
```

## 📚 Additional Resources

- [Crystal Language Documentation](https://crystal-lang.org/docs/)
- [Kemal Framework](https://kemalcr.com/)
- [Blockchain Basics](https://en.wikipedia.org/wiki/Blockchain)
- [Proof of Work Explained](https://en.wikipedia.org/wiki/Proof_of_work)

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👤 Author

**d80ep08th** - [@dxxepxxth](https://github.com/d80ep08th)

## 🙏 Acknowledgments

- Crystal community for the amazing language
- Kemal framework for easy web server setup
- All contributors to this learning project

---

**Happy Learning! 🚀** If you find this helpful, please ⭐ star the repository!
