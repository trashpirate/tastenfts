// SPDX-License-Identifier: MIT

/*

mint(uint256 quantity)
transferFrom(
        address from,
        address to,
        uint256 tokenId
    )
safeTransferFrom(
        address from,
        address to,
        uint256 tokenId
    )
approve(address to, uint256 tokenId)

*/

pragma solidity 0.8.18;

import {Script, console} from "forge-std/Script.sol";
import {DevOpsTools} from "foundry-devops/src/DevOpsTools.sol";
import {Venus} from "../src/Venus.sol";

contract MintNfts is Script {
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

contract TransferNft is Script {
    address NEW_USER = makeAddr("new-user");

    function transferNft(address recentContractAddress) public {
        vm.startBroadcast();
        Venus(recentContractAddress).transferFrom(tx.origin, NEW_USER, 0);
        vm.stopBroadcast();
    }

    function run() external {
        address recentContractAddress = DevOpsTools.get_most_recent_deployment("Venus", block.chainid);
        transferNft(recentContractAddress);
    }
}

contract ApproveNft is Script {
    address SENDER = makeAddr("sender");

    function approveNft(address recentContractAddress) public {
        vm.startBroadcast();
        Venus(recentContractAddress).approve(SENDER, 0);
        vm.stopBroadcast();
    }

    function run() external {
        address recentContractAddress = DevOpsTools.get_most_recent_deployment("Venus", block.chainid);
        approveNft(recentContractAddress);
    }
}
