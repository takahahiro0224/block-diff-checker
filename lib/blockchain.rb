require 'net/http'
require 'json'

# Blockchain.info API
class Blockchain

    # Gets the height of the latest block
    # https://www.blockchain.com/api/blockchain_api
    def latest_block
        begin
            JSON.parse(Net::HTTP.get(URI.parse('https://blockchain.info/latestblock')))['height']
        rescue => e
            p e.message
            raise FetchBlockchainInfoError.new
        end
    end
end

class FetchBlockchainInfoError < StandardError
    def initialize(msg='blockchain.infoからの情報取得でエラーが発生しました')
    super
    end
end
