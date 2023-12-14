// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.18;

import {Script} from "forge-std/Script.sol";
import {ERC20Token} from "../src/ERC20Token.sol";

contract DeployTokenContract is Script {
    function run() external returns (ERC20Token) {
        vm.startBroadcast();
        ERC20Token token = new ERC20Token();
        vm.stopBroadcast();
        return token;
    }
}
