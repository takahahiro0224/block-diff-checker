require 'dotenv'
require_relative 'slack_notifier'
require_relative 'blockchain'
require_relative 'bitcoind'


class Task
    def execute
        Dotenv.load(".env")

        block_from_explorer = Blockchain.new.latest_block
        block_from_bitcoind = Bitcoind.new(ENV['RPC_USER'], ENV['RPC_PASSWORD']).latest_block

        diff = (block_from_explorer - block_from_bitcoind).abs

        if diff >= 3 then
            msg = "The block difference between bitcoind and explorer is #{diff}."
            puts msg 
            SlackNotifier.new.post msg
        else
            puts "No difference between bitcoind and explorer."
        end
    end
end

Task.new.execute
