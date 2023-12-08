// SPDX-License-Identifier: MIT

pragma solidity 0.8.20;

import {Test, console} from "forge-std/Test.sol";
import {TasteNFTs} from "../src/TasteNFTs.sol";
import {DeployNFTContract} from "../script/DeployNFTContract.s.sol";
import {IERC20, ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract NFTContractTest is Test {
    TasteNFTs tasteNFTs;
    IERC20 token;

    address USER = makeAddr("user");
    address NEW_FEE_ADDRESS = makeAddr("fee");
    address OWNER;
    uint256 constant STARTING_BALANCE = 100_000_000_000 * 10 ** 9;

    uint256 constant INITIAL_FEE = 15_000_000_000 * 10 ** 9;
    uint256 constant NEW_FEE = 10_000_000_000 * 10 ** 9;

    modifier funded() {
        // fund user
        vm.prank(OWNER);
        token.transfer(USER, STARTING_BALANCE);
        _;
    }

    function setUp() external {
        DeployNFTContract deployment = new DeployNFTContract();
        tasteNFTs = deployment.run();
        token = tasteNFTs.paymentToken();

        OWNER = tasteNFTs.owner();
    }

    function testPaymentTokenName() public {
        address tokenAddress = address(tasteNFTs.paymentToken());
        string memory symbol = ERC20(tokenAddress).symbol();
        assertEq(symbol, "TASTE");
    }

    function testNFTTokenName() public {
        assertEq(tasteNFTs.name(), "TasteNFTs");
    }

    function testNFTTokenSymbol() public {
        assertEq(tasteNFTs.symbol(), "NFT");
    }

    function testNFTprice() public {
        uint256 fee = 15_000_000_000 * 10 ** ERC20(address(tasteNFTs.paymentToken())).decimals();
        assertEq(tasteNFTs.fee(), fee);
    }

    function testIfOwnerCanSetFee() public {
        vm.prank(OWNER);
        tasteNFTs.setFee(NEW_FEE);
        assertEq(tasteNFTs.fee(), NEW_FEE);
    }

    function testIfOwnerCanSetFeeAddress() public {
        vm.prank(OWNER);
        tasteNFTs.setFeeAddress(NEW_FEE_ADDRESS);
        assertEq(tasteNFTs.feeAddress(), NEW_FEE_ADDRESS);
    }

    function testIfOwnerCanSetBatchLimit() public {
        vm.prank(OWNER);
        tasteNFTs.setBatchLimit(3);
        assertEq(tasteNFTs.batchLimit(), 3);
    }

    function testIfOwnerCanSetMaxPerWallet() public {
        vm.prank(OWNER);
        tasteNFTs.setMaxPerWallet(11);
        assertEq(tasteNFTs.maxPerWallet(), 11);
    }

    function testRevertWhenBatchLimitGreaterThankMaxPerWallet() public {
        vm.expectRevert();
        vm.prank(OWNER);
        tasteNFTs.setBatchLimit(11);
    }

    function testRevertWhenMaxPerWalletSmallerThanBatchLimit() public {
        vm.expectRevert();
        vm.prank(OWNER);
        tasteNFTs.setMaxPerWallet(3);
    }

    function testIfOwnerCanWithdrawTokens() public funded {
        vm.prank(USER);
        token.transfer(address(tasteNFTs), STARTING_BALANCE / 2);
        uint256 contractBalance = token.balanceOf(address(tasteNFTs));
        assertGt(contractBalance, 0);

        uint256 initialBalance = token.balanceOf(OWNER);
        vm.prank(OWNER);
        tasteNFTs.withdrawTokens(address(token), OWNER);
        uint256 newBalance = token.balanceOf(OWNER);

        assertEq(token.balanceOf(address(tasteNFTs)), 0);
        assertGt(newBalance, initialBalance);
    }

    function testSetFeeRevertsIfNotOwner() public {
        vm.prank(USER);

        vm.expectRevert();
        tasteNFTs.setFee(NEW_FEE);
    }

    function testSetFeeAddressRevertsIfNotOwner() public {
        vm.prank(USER);

        vm.expectRevert();
        tasteNFTs.setFeeAddress(NEW_FEE_ADDRESS);
    }

    function testSetBatchLimitRevertsIfNotOwner() public {
        vm.prank(USER);

        vm.expectRevert();
        tasteNFTs.setBatchLimit(10);
    }

    function testSetMaxPerWalletRevertsIfNotOwner() public {
        vm.prank(USER);

        vm.expectRevert();
        tasteNFTs.setMaxPerWallet(100);
    }

    function testWithdrawTokensRevertsIfNotOwner() public funded {
        vm.prank(USER);
        token.transfer(address(tasteNFTs), STARTING_BALANCE / 2);
        uint256 contractBalance = token.balanceOf(address(tasteNFTs));
        assertGt(contractBalance, 0);

        vm.expectRevert();
        vm.prank(USER);
        tasteNFTs.withdrawTokens(address(token), USER);
    }

    function testMintSingleNFT() public funded {
        uint256 fee = tasteNFTs.fee();
        vm.prank(USER);
        token.approve(address(tasteNFTs), fee);

        vm.prank(USER);
        tasteNFTs.mint(1);
        assertEq(tasteNFTs.balanceOf(USER), 1);
    }

    function testMintMultipleNFTs() public funded {
        uint256 fee = 3 * tasteNFTs.fee();
        vm.prank(USER);
        token.approve(address(tasteNFTs), fee);

        vm.prank(USER);
        tasteNFTs.mint(3);
        assertEq(tasteNFTs.balanceOf(USER), 3);
    }

    function testChargesCorrectAmount() public funded {
        uint256 fee = 3 * tasteNFTs.fee();
        vm.prank(USER);
        token.approve(address(tasteNFTs), fee);

        uint256 initialBalance = token.balanceOf(USER);
        uint256 expectedBalance = initialBalance - fee;

        vm.prank(USER);
        tasteNFTs.mint(3);
        assertEq(token.balanceOf(USER), expectedBalance);
    }

    function testMintRevertsIfZero() public funded {
        uint256 fee = tasteNFTs.fee();
        vm.prank(USER);
        token.approve(address(tasteNFTs), fee);

        vm.expectRevert();
        vm.prank(USER);
        tasteNFTs.mint(0);
    }

    function testMintRevertsIfExceedsBatchLimit() public funded {
        vm.prank(OWNER);
        tasteNFTs.setBatchLimit(5);

        uint256 fee = 6 * tasteNFTs.fee();
        vm.prank(USER);
        token.approve(address(tasteNFTs), fee);

        vm.expectRevert();
        vm.prank(USER);
        tasteNFTs.mint(6);
    }

    function testMintRevertsIfExceedsMaxWalletLimit() public funded {
        uint256 fee = 6 * tasteNFTs.fee();
        vm.prank(USER);
        token.approve(address(tasteNFTs), fee);

        vm.expectRevert();
        vm.prank(USER);
        tasteNFTs.mint(6);
    }

    function testRevertsIfMaxExceeded() public funded {
        vm.prank(OWNER);
        tasteNFTs.setMaxPerWallet(1000);
        vm.prank(OWNER);
        tasteNFTs.setBatchLimit(100);

        uint256 fee = 100 * tasteNFTs.fee();
        for (uint256 index = 0; index < 10; index++) {
            vm.prank(OWNER);
            token.approve(address(tasteNFTs), fee);

            vm.prank(OWNER);
            tasteNFTs.mint(100);
        }

        fee = tasteNFTs.fee();
        vm.prank(USER);
        token.approve(address(tasteNFTs), fee);

        vm.expectRevert();
        vm.prank(USER);
        tasteNFTs.mint(1);
    }

    function testRevertIfInsufficientBalance() public funded {
        uint256 userBalance = token.balanceOf(USER);
        vm.prank(USER);
        token.approve(address(tasteNFTs), userBalance);

        vm.expectRevert();
        vm.prank(USER);
        tasteNFTs.mint(7);
    }
}
