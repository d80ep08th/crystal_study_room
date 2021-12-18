require "digest"

module Blockchain
  module ProofOfWork

    def proof_of_work(difficulty = "00")
      nonce = 0
      loop do
        hash = calc_hash_with_nonce(nonce)
        if hash[0..1] == difficulty
          return nonce
        else
          nonce += 1
        end
      end
    end

    def calc_hash_with_nonce(nonce = 0)
      #sha = OpenSSL::Digest.new("SHA256")
      #sha256 = Digest::SHA256.new
      #message = "#{nonce}#{@index}#{@timestamp}#{@transactions}#{@previous_hash}"
      #sha.update("#{nonce}#{@index}#{@timestamp}#{@transactions}#{@previous_hash}")
      #sha256.hexdigest(message)
      message = "#{nonce}#{@index}#{@timestamp}#{@previous_hash}"
      Digest::SHA256.hexdigest(message)
    end
  end
end
