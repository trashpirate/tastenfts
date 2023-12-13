// SPDX-License-Identifier: MIT

pragma solidity 0.8.20;

import {Script} from "forge-std/Script.sol";
import {DevOpsTools} from "foundry-devops/src/DevOpsTools.sol";
import {Venus} from "../src/Venus.sol";

contract OwnerInteractions is Script {}

/*
| └ | setFee | External ❗️ | 🛑  | onlyOwner |
| └ | setFeeAddress | External ❗️ | 🛑  | onlyOwner |
| └ | setMaxPerWallet | External ❗️ | 🛑  | onlyOwner |
| └ | setBatchLimit | External ❗️ | 🛑  | onlyOwner |
| └ | withdrawTokens | External ❗️ | 🛑  | onlyOwner |
*/
