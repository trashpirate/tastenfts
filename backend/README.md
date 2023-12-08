## Foundry

**Foundry is a blazing fast, portable and modular toolkit for Ethereum application development written in Rust.**

Foundry consists of:

-   **Forge**: Ethereum testing framework (like Truffle, Hardhat and DappTools).
-   **Cast**: Swiss army knife for interacting with EVM smart contracts, sending transactions and getting chain data.
-   **Anvil**: Local Ethereum node, akin to Ganache, Hardhat Network.
-   **Chisel**: Fast, utilitarian, and verbose solidity REPL.

## Documentation

https://book.getfoundry.sh/

## Usage

### Build

```shell
$ forge build
```

### Test

```shell
$ forge test
```

### Format

```shell
$ forge fmt
```

### Gas Snapshots

```shell
$ forge snapshot
```

### Anvil

```shell
$ anvil
```

### Deploy

```shell
$ forge script script/Counter.s.sol:CounterScript --rpc-url <your_rpc_url> --private-key <your_private_key>
```

### Cast

```shell
$ cast <subcommand>
```

### Help

```shell
$ forge --help
$ anvil --help
$ cast --help
```

### Manual Verification
```shell
forge verify-contract <contractAddress> src/TasteNFT.sol:CoinToken \
--etherscan-api-key <key> \
--constructor-args \
$(cast abi-encode \
"constructor(string,string,uint256,uint256,uint256,uint256,uint256,uint256,address,address)" \
"TasteNFT"\
"TASTE" \
9 \
1000000000000000 \
5 \
5 \
5000000000000000000000 \
50000000000 \
0x9Ac64Cc6e4415144C455BD8E4837Fea55603e5c3 \
0xCbA52038BF0814bC586deE7C061D6cb8B203f8e1\
) \
--chain-id 97

```

### Deployment
```shell
forge script script/DeployTASTEContract.s.sol --rpc-url bsctest --broadcast --account <AccountName> --sender <accountAddress>
```
