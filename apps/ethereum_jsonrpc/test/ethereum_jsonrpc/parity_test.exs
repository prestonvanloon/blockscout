defmodule EthereumJSONRPC.ParityTest do
  use ExUnit.Case, async: true
  use EthereumJSONRPC.Case

  import EthereumJSONRPC, only: [integer_to_quantity: 1]
  import Mox

  setup :verify_on_exit!

  doctest EthereumJSONRPC.Parity

  @moduletag :no_geth

  describe "fetch_internal_transactions/1" do
    test "with all valid transaction_params returns {:ok, transactions_params}", %{
      json_rpc_named_arguments: json_rpc_named_arguments
    } do
      from_address_hash = "0xe8ddc5c7a2d2f0d7a9798459c0104fdf5e987aca"
      gas = 4_533_872

      init =
        "0x6060604052341561000f57600080fd5b60405160208061071a83398101604052808051906020019091905050806000806101000a81548173ffffffffffffffffffffffffffffffffffffffff021916908373ffffffffffffffffffffffffffffffffffffffff1602179055506003600160006001600281111561007e57fe5b60ff1660ff168152602001908152602001600020819055506002600160006002808111156100a857fe5b60ff1660ff168152602001908152602001600020819055505061064a806100d06000396000f30060606040526004361061008e576000357c0100000000000000000000000000000000000000000000000000000000900463ffffffff168063247b3210146100935780632ffdfc8a146100bc57806374294144146100f6578063ae4b1b5b14610125578063bf7370d11461017a578063d1104cb2146101a3578063eecd1079146101f8578063fcff021c14610221575b600080fd5b341561009e57600080fd5b6100a661024a565b6040518082815260200191505060405180910390f35b34156100c757600080fd5b6100e0600480803560ff16906020019091905050610253565b6040518082815260200191505060405180910390f35b341561010157600080fd5b610123600480803590602001909190803560ff16906020019091905050610276565b005b341561013057600080fd5b61013861037a565b604051808273ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200191505060405180910390f35b341561018557600080fd5b61018d61039f565b6040518082815260200191505060405180910390f35b34156101ae57600080fd5b6101b66104d9565b604051808273ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200191505060405180910390f35b341561020357600080fd5b61020b610588565b6040518082815260200191505060405180910390f35b341561022c57600080fd5b6102346105bd565b6040518082815260200191505060405180910390f35b600060c8905090565b6000600160008360ff1660ff168152602001908152602001600020549050919050565b61027e6104d9565b73ffffffffffffffffffffffffffffffffffffffff163373ffffffffffffffffffffffffffffffffffffffff161415156102b757600080fd5b60008160ff161115156102c957600080fd5b6002808111156102d557fe5b60ff168160ff16111515156102e957600080fd5b6000821180156103125750600160008260ff1660ff168152602001908152602001600020548214155b151561031d57600080fd5b81600160008360ff1660ff168152602001908152602001600020819055508060ff167fe868bbbdd6cd2efcd9ba6e0129d43c349b0645524aba13f8a43bfc7c5ffb0889836040518082815260200191505060405180910390a25050565b6000809054906101000a900473ffffffffffffffffffffffffffffffffffffffff1681565b6000806000809054906101000a900473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16638b8414c46000604051602001526040518163ffffffff167c0100000000000000000000000000000000000000000000000000000000028152600401602060405180830381600087803b151561042f57600080fd5b6102c65a03f1151561044057600080fd5b5050506040518051905090508073ffffffffffffffffffffffffffffffffffffffff16630eaba26a6000604051602001526040518163ffffffff167c0100000000000000000000000000000000000000000000000000000000028152600401602060405180830381600087803b15156104b857600080fd5b6102c65a03f115156104c957600080fd5b5050506040518051905091505090565b60008060009054906101000a900473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1663a3b3fff16000604051602001526040518163ffffffff167c0100000000000000000000000000000000000000000000000000000000028152600401602060405180830381600087803b151561056857600080fd5b6102c65a03f1151561057957600080fd5b50505060405180519050905090565b60006105b860016105aa600261059c61039f565b6105e590919063ffffffff16565b61060090919063ffffffff16565b905090565b60006105e06105ca61039f565b6105d261024a565b6105e590919063ffffffff16565b905090565b60008082848115156105f357fe5b0490508091505092915050565b600080828401905083811015151561061457fe5b80915050929150505600a165627a7a723058206b7eef2a57eb659d5e77e45ab5bc074e99c6a841921038cdb931e119c6aac46c0029000000000000000000000000862d67cb0773ee3f8ce7ea89b328ffea861ab3ef"

      value = 0
      block_number = 1
      index = 0
      created_contract_address_hash = "0x1e0eaa06d02f965be2dfe0bc9ff52b2d82133461"

      created_contract_code =
        "0x60606040526004361061008e576000357c0100000000000000000000000000000000000000000000000000000000900463ffffffff168063247b3210146100935780632ffdfc8a146100bc57806374294144146100f6578063ae4b1b5b14610125578063bf7370d11461017a578063d1104cb2146101a3578063eecd1079146101f8578063fcff021c14610221575b600080fd5b341561009e57600080fd5b6100a661024a565b6040518082815260200191505060405180910390f35b34156100c757600080fd5b6100e0600480803560ff16906020019091905050610253565b6040518082815260200191505060405180910390f35b341561010157600080fd5b610123600480803590602001909190803560ff16906020019091905050610276565b005b341561013057600080fd5b61013861037a565b604051808273ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200191505060405180910390f35b341561018557600080fd5b61018d61039f565b6040518082815260200191505060405180910390f35b34156101ae57600080fd5b6101b66104d9565b604051808273ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200191505060405180910390f35b341561020357600080fd5b61020b610588565b6040518082815260200191505060405180910390f35b341561022c57600080fd5b6102346105bd565b6040518082815260200191505060405180910390f35b600060c8905090565b6000600160008360ff1660ff168152602001908152602001600020549050919050565b61027e6104d9565b73ffffffffffffffffffffffffffffffffffffffff163373ffffffffffffffffffffffffffffffffffffffff161415156102b757600080fd5b60008160ff161115156102c957600080fd5b6002808111156102d557fe5b60ff168160ff16111515156102e957600080fd5b6000821180156103125750600160008260ff1660ff168152602001908152602001600020548214155b151561031d57600080fd5b81600160008360ff1660ff168152602001908152602001600020819055508060ff167fe868bbbdd6cd2efcd9ba6e0129d43c349b0645524aba13f8a43bfc7c5ffb0889836040518082815260200191505060405180910390a25050565b6000809054906101000a900473ffffffffffffffffffffffffffffffffffffffff1681565b6000806000809054906101000a900473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16638b8414c46000604051602001526040518163ffffffff167c0100000000000000000000000000000000000000000000000000000000028152600401602060405180830381600087803b151561042f57600080fd5b6102c65a03f1151561044057600080fd5b5050506040518051905090508073ffffffffffffffffffffffffffffffffffffffff16630eaba26a6000604051602001526040518163ffffffff167c0100000000000000000000000000000000000000000000000000000000028152600401602060405180830381600087803b15156104b857600080fd5b6102c65a03f115156104c957600080fd5b5050506040518051905091505090565b60008060009054906101000a900473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1663a3b3fff16000604051602001526040518163ffffffff167c0100000000000000000000000000000000000000000000000000000000028152600401602060405180830381600087803b151561056857600080fd5b6102c65a03f1151561057957600080fd5b50505060405180519050905090565b60006105b860016105aa600261059c61039f565b6105e590919063ffffffff16565b61060090919063ffffffff16565b905090565b60006105e06105ca61039f565b6105d261024a565b6105e590919063ffffffff16565b905090565b60008082848115156105f357fe5b0490508091505092915050565b600080828401905083811015151561061457fe5b80915050929150505600a165627a7a723058206b7eef2a57eb659d5e77e45ab5bc074e99c6a841921038cdb931e119c6aac46c0029"

      gas_used = 382_953
      trace_address = []
      transaction_hash = "0x0fa6f723216dba694337f9bb37d8870725655bdf2573526a39454685659e39b1"
      type = "create"

      if json_rpc_named_arguments[:transport] == EthereumJSONRPC.Mox do
        expect(EthereumJSONRPC.Mox, :json_rpc, fn _json, _options ->
          {:ok,
           [
             %{
               id: 0,
               result: %{
                 "trace" => [
                   %{
                     "action" => %{
                       "from" => from_address_hash,
                       "gas" => integer_to_quantity(gas),
                       "init" => init,
                       "value" => integer_to_quantity(value)
                     },
                     "blockNumber" => block_number,
                     "index" => index,
                     "result" => %{
                       "address" => created_contract_address_hash,
                       "code" => created_contract_code,
                       "gasUsed" => integer_to_quantity(gas_used)
                     },
                     "traceAddress" => trace_address,
                     "transactionHash" => transaction_hash,
                     "type" => type
                   }
                 ]
               }
             }
           ]}
        end)
      end

      assert EthereumJSONRPC.Parity.fetch_internal_transactions(
               [
                 %{
                   block_number: block_number,
                   hash_data: transaction_hash
                 }
               ],
               json_rpc_named_arguments
             ) == {
               :ok,
               [
                 %{
                   block_number: 1,
                   created_contract_address_hash: created_contract_address_hash,
                   created_contract_code: created_contract_code,
                   from_address_hash: from_address_hash,
                   gas: gas,
                   gas_used: gas_used,
                   index: index,
                   init: init,
                   trace_address: trace_address,
                   transaction_hash: transaction_hash,
                   type: type,
                   value: value
                 }
               ]
             }
    end

    test "with all invalid transaction_params returns {:error, reasons}", %{
      json_rpc_named_arguments: json_rpc_named_arguments
    } do
      if json_rpc_named_arguments[:transport] == EthereumJSONRPC.Mox do
        expect(EthereumJSONRPC.Mox, :json_rpc, fn _json, _options ->
          {:ok,
           [
             %{
               id: 0,
               error: %{
                 code: -32603,
                 message: "Internal error occurred: {}, this should not be the case with eth_call, most likely a bug."
               }
             }
           ]}
        end)
      end

      assert EthereumJSONRPC.Parity.fetch_internal_transactions(
               [
                 %{
                   block_number: 1,
                   hash_data: "0x0000000000000000000000000000000000000000000000000000000000000001"
                 }
               ],
               json_rpc_named_arguments
             ) ==
               {:error,
                [
                  %{
                    code: -32603,
                    data: %{
                      "blockNumber" => 1,
                      "transactionHash" => "0x0000000000000000000000000000000000000000000000000000000000000001"
                    },
                    message:
                      "Internal error occurred: {}, this should not be the case with eth_call, most likely a bug."
                  }
                ]}
    end

    test "with a mix of valid and invalid transaction_params returns {:error, reasons}", %{
      json_rpc_named_arguments: json_rpc_named_arguments
    } do
      if json_rpc_named_arguments[:transport] == EthereumJSONRPC.Mox do
        expect(EthereumJSONRPC.Mox, :json_rpc, fn _json, _options ->
          {:ok,
           [
             %{
               id: 0,
               result: %{
                 "trace" => []
               }
             },
             %{
               id: 1,
               result: %{
                 "trace" => []
               }
             },
             %{
               id: 2,
               error: %{
                 code: -32603,
                 message: "Internal error occurred: {}, this should not be the case with eth_call, most likely a bug."
               }
             },
             %{
               id: 3,
               error: %{
                 code: -32603,
                 message: "Internal error occurred: {}, this should not be the case with eth_call, most likely a bug."
               }
             }
           ]}
        end)
      end

      assert EthereumJSONRPC.Parity.fetch_internal_transactions(
               [
                 # start with :ok
                 %{
                   block_number: 1,
                   hash_data: "0x0fa6f723216dba694337f9bb37d8870725655bdf2573526a39454685659e39b1"
                 },
                 # :ok, :ok clause
                 %{
                   block_number: 34,
                   hash_data: "0x3a3eb134e6792ce9403ea4188e5e79693de9e4c94e499db132be086400da79e6"
                 },
                 # :ok, :error clause
                 %{
                   block_number: 1,
                   hash_data: "0x0000000000000000000000000000000000000000000000000000000000000001"
                 },
                 # :error, :error clause
                 %{
                   block_number: 2,
                   hash_data: "0x0000000000000000000000000000000000000000000000000000000000000002"
                 }
               ],
               json_rpc_named_arguments
             ) ==
               {:error,
                [
                  %{
                    code: -32603,
                    data: %{
                      "blockNumber" => 1,
                      "transactionHash" => "0x0000000000000000000000000000000000000000000000000000000000000001"
                    },
                    message:
                      "Internal error occurred: {}, this should not be the case with eth_call, most likely a bug."
                  },
                  %{
                    code: -32603,
                    data: %{
                      "blockNumber" => 2,
                      "transactionHash" => "0x0000000000000000000000000000000000000000000000000000000000000002"
                    },
                    message:
                      "Internal error occurred: {}, this should not be the case with eth_call, most likely a bug."
                  }
                ]}
    end
  end
end
