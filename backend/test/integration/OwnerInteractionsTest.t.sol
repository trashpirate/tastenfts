// SPDX-License-Identifier: MIT

pragma solidity 0.8.18;

import {Test, console} from "forge-std/Test.sol";
import {Venus} from "../../src/Venus.sol";
import {DeployNFTContract} from "../../script/DeployNFTContract.s.sol";
import {IERC20, ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {
    SetNewFee,
    SetNewFeeAddress,
    SetNewMaxPerWallet,
    SetNewBatchLimit,
    WithdrawTokensFromContract
} from "../../script/OwnerInteractions.s.sol";

contract OwnerInteractionsTest is Test {
    Venus nftContract;
    IERC20 token;

    address USER = makeAddr("user");
    address NEW_FEE_ADDRESS = makeAddr("fee");
    address OWNER;
    uint256 constant TOKEN_BALANCE = 100_000_000_000 * 10 ** 9;

    uint256 constant INITIAL_FEE = 15_000_000_000 * 10 ** 9;
    uint256 constant NEW_FEE = 10_000_000_000 * 10 ** 9;

    function setUp() external {
        DeployNFTContract deployment = new DeployNFTContract();
        nftContract = deployment.run();
        token = nftContract.paymentToken();
        OWNER = nftContract.owner();
        vm.prank(OWNER);
        nftContract.transferOwnership(msg.sender);
    }

    function testOwnerCanSetFee() public {
        SetNewFee setNewFee = new SetNewFee();
        setNewFee.setNewFee(address(nftContract));
    }

    function testOwnerCanSetFeeAddress() public {
        SetNewFeeAddress setNewFeeAddress = new SetNewFeeAddress();
        setNewFeeAddress.setNewFeeAddress(address(nftContract));
    }

    function testOwnerCanSetMaxPerWallet() public {
        SetNewMaxPerWallet setNewMaxPerWallet = new SetNewMaxPerWallet();
        setNewMaxPerWallet.setNewMaxPerWallet(address(nftContract));
    }

    function testOwnerCanSetBatchLimit() public {
        SetNewBatchLimit setNewBatchLimit = new SetNewBatchLimit();
        setNewBatchLimit.setNewBatchLimit(address(nftContract));
    }

    function testOwnerWithdrawTokens() public {
        vm.prank(OWNER);
        token.transfer(address(nftContract), TOKEN_BALANCE);
        WithdrawTokensFromContract withdrawTokensFromContract = new WithdrawTokensFromContract();
        withdrawTokensFromContract.withrawTokensFromContract(address(nftContract));
    }
}
