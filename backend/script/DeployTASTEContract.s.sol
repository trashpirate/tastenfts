// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.18;

import {Script} from "forge-std/Script.sol";
import {CoinToken} from "../src/TasteNFT.sol";

contract DeployTASTEContract is Script {
    string name = "TasteNFT";
    string symbol = "TASTE";
    uint256 decimals = 9;
    uint256 supply = 1000000000000000;
    uint256 taxFee = 5;
    uint256 lpFee = 5;
    uint256 maxTxAmount = 5000000000000000000000;
    uint256 maxSellAmount = 50000000000;
    address routerAddress = 0x9Ac64Cc6e4415144C455BD8E4837Fea55603e5c3;
    address tokenOwner = 0xCbA52038BF0814bC586deE7C061D6cb8B203f8e1;

    function run() external returns (CoinToken) {
        vm.startBroadcast();
        CoinToken token = new CoinToken(
            name, symbol, decimals, supply, taxFee, lpFee, maxTxAmount, maxSellAmount, routerAddress, tokenOwner
        );
        vm.stopBroadcast();
        return token;
    }
}

// deploy
// forge script script/DeployTASTEContract.s.sol --rpc-url bsctest --broadcast --account <AccountName> --sender <accountAddress>

// manually verify

/*
forge verify-contract <contractAddress> src/TasteNFT.sol:CoinToken \
--etherscan-api-key $BSCSCAN_KEY \
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
*/
