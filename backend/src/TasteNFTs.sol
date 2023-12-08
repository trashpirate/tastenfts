// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@erc721a/contracts/ERC721A.sol";

contract TasteNFTs is ERC721A, Ownable {
    uint256 public constant MAX_SUPPLY = 1000;

    IERC20 public immutable paymentToken;
    address public feeAddress;
    uint256 public fee = 15_000_000_000 * 10 ** 9;
    uint256 public batchLimit = 5;
    uint256 public maxPerWallet = 5;

    string private _baseTokenURI;

    constructor(address initialOwner, address initialFeeAddress, address tokenAddress, string memory baseURI)
        ERC721A("TasteNFTs", "NFT")
        Ownable(initialOwner)
    {
        feeAddress = initialFeeAddress;
        paymentToken = IERC20(tokenAddress);
        _setBaseURI(baseURI);
    }

    // set base uri
    function _setBaseURI(string memory baseURI) private {
        _baseTokenURI = baseURI;
    }

    // retrieve base uri
    function _baseURI() internal view override returns (string memory) {
        return _baseTokenURI;
    }

    // mint NFT for token fee
    function mint(uint256 quantity) external {
        require(quantity > 0, "Quantity must be greater than zero.");
        require(quantity <= batchLimit, "Exceeds batch limit.");
        require(_totalMinted() + quantity <= MAX_SUPPLY, "Exceeds max supply.");
        require(balanceOf(msg.sender) + quantity <= maxPerWallet, "Exceeds max per wallet.");

        _mint(msg.sender, quantity);
        bool success = paymentToken.transferFrom(msg.sender, feeAddress, fee * quantity);
        require(success, "Token transfer failed");
    }

    // set fee (only owner)
    function setFee(uint256 newFee) external onlyOwner {
        fee = newFee;
    }

    // set the receiver address (only owner)
    function setFeeAddress(address newFeeAddress) external onlyOwner {
        require(newFeeAddress != address(0), "Fee address is zero address");
        feeAddress = newFeeAddress;
    }

    // set the maximum number of nfts per wallet (only owner)
    function setMaxPerWallet(uint256 newMaxMint) external onlyOwner {
        require(newMaxMint <= MAX_SUPPLY, "Max mint per wallet exceeds max supply");
        require(newMaxMint >= batchLimit, "Max mint per wallet smaller than batch limit");
        maxPerWallet = newMaxMint;
    }

    // set batch limit (only owner)
    function setBatchLimit(uint256 newLimit) external onlyOwner {
        require(newLimit <= 100, "Batch limit exceeds maximum allowed");
        require(newLimit <= maxPerWallet, "Batch limit exceeds max mint per wallet");
        batchLimit = newLimit;
    }

    // withdraw tokens from contract (only owner)
    function withdrawTokens(address tokenAddress, address receiverAddress) external onlyOwner returns (bool success) {
        IERC20 tokenContract = IERC20(tokenAddress);
        uint256 amount = tokenContract.balanceOf(address(this));
        success = tokenContract.transfer(receiverAddress, amount);
    }
}
