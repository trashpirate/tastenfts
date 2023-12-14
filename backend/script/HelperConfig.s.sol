// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

import {Script, console} from "forge-std/Script.sol";
import {CoinToken} from "../src/TasteNFT.sol";

contract HelperConfig is Script {
    // TASTE deployment arguments
    string public constant NAME = "TasteNFT";
    string public constant SYMBOL = "TASTE";
    uint256 public constant DECIMALS = 9;
    uint256 public constant SUPPLY = 1_000_000_000_000_000 * 10 ** 9;
    uint256 public constant TAXFEE = 5;
    uint256 public constant LPFEE = 5;
    uint256 public constant MAXTXAMOUNT = 5000000000000000000000;
    uint256 public constant MAXSELLAMOUNT = 50000000000;
    address public constant ROUTERADDRESS = 0x10ED43C718714eb63d5aA57B78B54704E256024E;
    address public constant TOKENOWNER = 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266;

    // chain configurations
    NetworkConfig public activeNetworkConfig;

    struct NetworkConfig {
        address initialOwner;
        address feeAddress;
        address tokenAddress;
    }

    constructor() {
        if (block.chainid == 56) {
            activeNetworkConfig = getBscMainnetConfig();
        } else if (block.chainid == 97) {
            activeNetworkConfig = getBscTestnetConfig();
        } else {
            activeNetworkConfig = getAnvilConfig();
        }
    }

    function getBscTestnetConfig() public pure returns (NetworkConfig memory) {
        return NetworkConfig({
            initialOwner: 0xCbA52038BF0814bC586deE7C061D6cb8B203f8e1,
            feeAddress: 0xCbA52038BF0814bC586deE7C061D6cb8B203f8e1,
            tokenAddress: 0x855dA24D2Fc7eF7aAcf29b3d027Ec70ab11847df
        });
    }

    function getBscMainnetConfig() public pure returns (NetworkConfig memory) {
        return NetworkConfig({
            initialOwner: 0x7526553689E14F2D7E172713e1F232d8048cf613,
            feeAddress: 0x9987605c8741d945098D7D6ba30bC41ACc1B821e,
            tokenAddress: 0xdB238123939637D65a03E4b2b485650B4f9D91CB
        });
    }

    function getAnvilConfig() public returns (NetworkConfig memory) {
        // Deploy mock contract
        vm.startBroadcast();

        CoinToken token = new CoinToken(
            NAME, SYMBOL, DECIMALS, SUPPLY, TAXFEE, LPFEE, MAXTXAMOUNT, MAXSELLAMOUNT, ROUTERADDRESS, TOKENOWNER
        );
        vm.stopBroadcast();
        return NetworkConfig({
            initialOwner: 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266,
            feeAddress: 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266,
            tokenAddress: address(token)
        });
    }
}
