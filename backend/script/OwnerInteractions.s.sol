// SPDX-License-Identifier: MIT

pragma solidity 0.8.18;

import {Script, console} from "forge-std/Script.sol";
import {DevOpsTools} from "foundry-devops/src/DevOpsTools.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {Venus} from "../src/Venus.sol";

contract SetNewFee is Script {
    uint256 constant NEW_FEE = 15_000_000_000 * 10 ** 9;
    address NEW_FEE_ADDRESS = makeAddr("new-fee-address");
    uint256 constant NEW_MAX_PER_WALLET = 10;
    uint256 constant NEW_BATCH_LIMIT = 10;
    IERC20 token;

    function setNewFee(address recentContractAddress) public {
        vm.startBroadcast();
        Venus(recentContractAddress).setFee(NEW_FEE);
        vm.stopBroadcast();
    }

    function run() external {
        address recentContractAddress = DevOpsTools.get_most_recent_deployment("Venus", block.chainid);
        setNewFee(recentContractAddress);
    }
}

contract SetNewFeeAddress is Script {
    uint256 constant NEW_FEE = 15_000_000_000 * 10 ** 9;
    address NEW_FEE_ADDRESS = makeAddr("new-fee-address");
    uint256 constant NEW_MAX_PER_WALLET = 10;
    uint256 constant NEW_BATCH_LIMIT = 10;
    IERC20 token;

    function setNewFeeAddress(address recentContractAddress) public {
        vm.startBroadcast();
        Venus(recentContractAddress).setFeeAddress(NEW_FEE_ADDRESS);
        vm.stopBroadcast();
    }

    function run() external {
        address recentContractAddress = DevOpsTools.get_most_recent_deployment("Venus", block.chainid);

        setNewFeeAddress(recentContractAddress);
    }
}

contract SetNewMaxPerWallet is Script {
    uint256 constant NEW_FEE = 15_000_000_000 * 10 ** 9;
    address NEW_FEE_ADDRESS = makeAddr("new-fee-address");
    uint256 constant NEW_MAX_PER_WALLET = 10;
    uint256 constant NEW_BATCH_LIMIT = 10;
    IERC20 token;

    function setNewMaxPerWallet(address recentContractAddress) public {
        vm.startBroadcast();
        Venus(recentContractAddress).setMaxPerWallet(NEW_MAX_PER_WALLET);
        vm.stopBroadcast();
    }

    function run() external {
        address recentContractAddress = DevOpsTools.get_most_recent_deployment("Venus", block.chainid);
        setNewMaxPerWallet(recentContractAddress);
    }
}

contract SetNewBatchLimit is Script {
    uint256 constant NEW_FEE = 15_000_000_000 * 10 ** 9;
    address NEW_FEE_ADDRESS = makeAddr("new-fee-address");
    uint256 constant NEW_MAX_PER_WALLET = 10;
    uint256 constant NEW_BATCH_LIMIT = 3;
    IERC20 token;

    function setNewBatchLimit(address recentContractAddress) public {
        vm.startBroadcast();
        Venus(recentContractAddress).setBatchLimit(NEW_BATCH_LIMIT);
        vm.stopBroadcast();
    }

    function run() external {
        address recentContractAddress = DevOpsTools.get_most_recent_deployment("Venus", block.chainid);
        setNewBatchLimit(recentContractAddress);
    }
}

contract WithdrawTokensFromContract is Script {
    uint256 constant NEW_FEE = 15_000_000_000 * 10 ** 9;
    address NEW_FEE_ADDRESS = makeAddr("new-fee-address");
    uint256 constant NEW_MAX_PER_WALLET = 10;
    uint256 constant NEW_BATCH_LIMIT = 10;
    IERC20 token;

    function withrawTokensFromContract(address recentContractAddress) public {
        vm.startBroadcast();
        Venus(recentContractAddress).withdrawTokens(address(Venus(recentContractAddress).paymentToken()), address(this));
        vm.stopBroadcast();
    }

    function run() external {
        address recentContractAddress = DevOpsTools.get_most_recent_deployment("Venus", block.chainid);
        withrawTokensFromContract(recentContractAddress);
    }
}
