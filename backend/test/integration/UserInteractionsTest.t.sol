// SPDX-License-Identifier: MIT

pragma solidity 0.8.20;

import {Test, console} from "forge-std/Test.sol";
import {Venus} from "../../src/Venus.sol";
import {DeployNFTContract} from "../../script/DeployNFTContract.s.sol";
import {IERC20, ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {MintNfts} from "../../script/UserInteractions.s.sol";

contract NFTContractTest is Test {
    Venus nftContract;
    IERC20 token;

    address USER = makeAddr("user");
    address NEW_FEE_ADDRESS = makeAddr("fee");
    address OWNER;
    uint256 constant STARTING_BALANCE = 100_000_000_000 * 10 ** 9;

    uint256 constant INITIAL_FEE = 15_000_000_000 * 10 ** 9;
    uint256 constant NEW_FEE = 10_000_000_000 * 10 ** 9;

    modifier fundedAndApproved() {
        // fund user
        vm.prank(OWNER);
        token.transfer(msg.sender, STARTING_BALANCE);
        vm.prank(msg.sender);
        token.approve(address(nftContract), STARTING_BALANCE);
        _;
    }

    function setUp() external {
        DeployNFTContract deployment = new DeployNFTContract();
        nftContract = deployment.run();
        token = nftContract.paymentToken();
        OWNER = nftContract.owner();
    }

    function testUserCanMintSingleNft() public fundedAndApproved {
        MintNfts mintNfts = new MintNfts();
        mintNfts.mintSingleNft(address(nftContract));
    }

    function testUserCanMintMultipleNfts() public fundedAndApproved {
        MintNfts mintNfts = new MintNfts();
        mintNfts.mintMultipleNfts(address(nftContract));
    }
}
