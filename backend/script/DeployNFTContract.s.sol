// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.18;

import {Script, console} from "forge-std/Script.sol";
import {Venus} from "../src/Venus.sol";
import {HelperConfig} from "./HelperConfig.s.sol";

contract DeployNFTContract is Script {
    string baseUri = "ipfs://bafybeighyfpbm5wvkp6twl5jpyft3k7ai2xy4sseoxja4qcrz4eql3gq4a/";

    function run() external returns (Venus) {
        HelperConfig helperConfig = new HelperConfig();
        (address initialOwner, address feeAddress, address tokenAddress) = helperConfig.activeNetworkConfig();

        // after broadcast is real transaction, before just simulation
        vm.startBroadcast();
        Venus nfts = new Venus(initialOwner, feeAddress, tokenAddress, baseUri);
        vm.stopBroadcast();
        return nfts;
    }
}
