// SPDX-License-Identifier: MIT

pragma solidity 0.8.20;

import {Script, console} from "forge-std/Script.sol";
import {DevOpsTools} from "foundry-devops/src/DevOpsTools.sol";
import {Venus} from "../src/Venus.sol";

contract MintNfts is Script {
    uint256 constant QUANTITY = 2;

    function mintSingleNft(address recentContractAddress) public {
        vm.startBroadcast();
        Venus(recentContractAddress).mint(1);
        vm.stopBroadcast();
        console.log("Minted 1 NFT with:", msg.sender);
    }

    function mintMultipleNfts(address recentContractAddress) public {
        vm.startBroadcast();
        Venus(recentContractAddress).mint(3);
        vm.stopBroadcast();
        console.log("Minted 3 NFT with:", msg.sender);
    }

    function run() external {
        address recentContractAddress = DevOpsTools.get_most_recent_deployment("Venus", block.chainid);
        mintSingleNft(recentContractAddress);
        mintMultipleNfts(recentContractAddress);
    }
}
