require 'faraday'
require 'faraday/net_http'
require 'json'

class Bitcoind

    def initialize(rpc_user, rpc_password)
        Faraday.default_adapter = :net_http
        @conn = Faraday.new(
            url: "http://#{rpc_user}:#{rpc_password}@127.0.0.1:8332",
            headers: {'Conetnt-Type' => 'text/plain'}
        )
    end

    # https://bitcoincore.org/en/doc/22.0.0/rpc/blockchain/getblockchaininfo/
    def latest_block
        begin
            response = @conn.post('/') do |req|
                req.body = '{"jsonrpc":"1.0","id":"1","method":"getblockchaininfo","params":[]}'
            end
        rescue Faraday::ConnectionFailed => e
            p e.message
            raise BitcoindConnectionError
        rescue => e
            raise e
        end
        JSON.parse(response.body)['result']['blocks']
    end
end

class BitcoindConnectionError < StandardError
    def initialize(msg='bitcoindとの接続に失敗しました。bitcoindが起動しているか確認してください')
    super
    end
end
