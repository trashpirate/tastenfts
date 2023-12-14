-include .env

.PHONY: all test clean deploy-anvil

# Clean the repo
clean  :; forge clean

# Remove modules
remove :; rm -rf .gitmodules && rm -rf .git/modules/* && rm -rf lib && touch .gitmodules && git add . && git commit -m "modules"

install :; forge install smartcontractkit/chainlink-brownie-contracts && forge install rari-capital/solmate && forge install foundry-rs/forge-std

# Update Dependencies
update:; forge update

build:; forge build

test :; forge test 

snapshot :; forge snapshot

slither :; slither ./src 

format :; prettier --write src/**/*.sol && prettier --write src/*.sol

# solhint should be installed globally
lint :; solhint src/**/*.sol && solhint src/*.sol

anvil :; anvil -m 'test test test test test test test test test test test junk'

anvil-bsc :; @anvil --fork-url ${RPC_BSC} --fork-block-number 24365190 --fork-chain-id 56 --chain-id 123

# use the "@" to hide the command from your shell, use contract=<contract name>
deploy-testnet :; @forge script script/Deploy${contract}.s.sol:Deploy${contract} --rpc-url ${network}  --account Testing --sender 0x7Bb8be3D9015682d7AC0Ea377dC0c92B0ba152eF --broadcast --verify --etherscan-api-key ${network}  -vvvv
deploy-testnet-simulate :; @forge script script/Deploy${contract}.s.sol:Deploy${contract} --rpc-url ${network}  --account Testing --sender 0x7Bb8be3D9015682d7AC0Ea377dC0c92B0ba152eF -vvvv

deploy-mainnet :; @forge script script/Deploy${contract}.s.sol:Deploy${contract} --rpc-url ${network}  --account ${account} --sender ${sender} --broadcast --verify --etherscan-api-key ${network}  -vvvv
deploy-mainnet-simulate :; @forge script script/Deploy${contract}.s.sol:Deploy${contract} --rpc-url ${network}  --account ${account} --sender ${sender}  -vvvv

# This is the private key of account from the mnemonic from the "make anvil" command
deploy-anvil :; @forge script script/${contract}.s.sol:Deploy${contract} --rpc-url http://localhost:8545  --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80 --broadcast 

deploy-all :; make deploy-${network} contract=APIConsumer && make deploy-${network} contract=KeepersCounter && make deploy-${network} contract=PriceFeedConsumer && make deploy-${network} contract=VRFConsumerV2


test-local-all :; @forge test --rpc-url localhost

fuzz-test-local :; @forge test --match-path test/fuzz/* --rpc-url localhost

unit-test-local :; @forge test --match-path test/unit/* --rpc-url localhost -vvv

integration-test-local :; @forge test --match-path test/integration/* --rpc-url localhost -vvv
integration-test-user :; @forge test --match-path test/integration/UserInteractionsTest.t.sol --rpc-url localhost -vvv
integration-test-owner :; @forge test --match-path test/integration/OwnerInteractionsTest.t.sol --rpc-url localhost -vvv

-include ${FCT_PLUGIN_PATH}/makefile-external