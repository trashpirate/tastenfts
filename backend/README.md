# VENUS COLLECTION - SMART CONTRACTS

![Version](https://img.shields.io/badge/version-1.0.0-blue.svg?style=for-the-badge)
![Forge](https://img.shields.io/badge/Forge-v0.2.0-blue?style=for-the-badge)
[![License: MIT](https://img.shields.io/github/license/trashpirate/hold-earn.svg?style=for-the-badge)](https://github.com/trashpirate/hold-earn/blob/main/LICENSE)

[![Website: nadinaoates.com](https://img.shields.io/badge/Portfolio-00e0a7?style=for-the-badge&logo=Website)](https://nadinaoates.com)
[![LinkedIn: nadinaoates](https://img.shields.io/badge/LinkedIn-0a66c2?style=for-the-badge&logo=LinkedIn&logoColor=f5f5f5)](https://linkedin.com/in/nadinaoates)
[![Twitter: N0\_crypto](https://img.shields.io/badge/@N0\_crypto-black?style=for-the-badge&logo=X)](https://twitter.com/N0\_crypto)

<!-- ![Node](https://img.shields.io/badge/node-v20.10.0-blue.svg?style=for-the-badge)
![NPM](https://img.shields.io/badge/npm-v10.2.3-blue?style=for-the-badge)
![Nextjs](https://img.shields.io/badge/next-v13.5.4-blue?style=for-the-badge)
![Tailwindcss](https://img.shields.io/badge/TailwindCSS-v3.0-blue?style=for-the-badge)
![Wagmi](https://img.shields.io/badge/Wagmi-v1.4.3-blue?style=for-the-badge) -->


<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#installation">Installation</a></li>
        <li><a href="#usage">Usage</a></li>
      </ul>
    </li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
    <!-- <li><a href="#acknowledgments">Acknowledgments</a></li> -->
  </ol>
</details>

<!-- ABOUT THE PROJECT -->

## About The Project

This repository contains the smart contract and deployment/testing suite to create an NFT collection consisting of 1000 unique AI-generated images known as "VENUS Collection." These flame creatures come with five different traits of varying rarity: BLACK (750), BLUE (150), PURPLE (75), PINK (20), and RED (5). The repo includes code for generating the collection for upload on [IPFS](https://ipfs.tech/), for testing and deploying the NFT smart contracts, and the frontend for the minting dapp.

### Smart Contracts Testnet

**Payment Token Contract**   
https://testnet.bscscan.com/address/0x855da24d2fc7ef7aacf29b3d027ec70ab11947df

**NFT Contract**   
https://testnet.bscscan.com/address/0x5ca6d70e6d92b2bf5e7a488bcac4378f92f09192

### Smart Contracts Mainnet

**Payment Token Contract**   
https://bscscan.com/token/0xdb238123939637d65a03e4b2b485650b4f9d91cb

**NFT Contract**   
https://bscscan.com/token/0xe779228037affe34f9beeeb4397ffb5264ede9fe

<!-- GETTING STARTED -->

## Getting Started

### Installation

1. Clone the repo
   ```sh
   git clone https://github.com/trashpirate/venus-collection.git
   ```
2. Navigate to the project directory
   ```sh
   cd venus-collection/backend
   ```
3. Install Forge submodules
   ```sh
   forge install
   ```


### Usage

#### Compiling
```sh
forge compile
```

#### Testing locally

1. Start local test environment
    ```sh
    make anvil-bsc
    ```
2. Run local tests
    ```sh
    make test-local-all
    ```

#### Deploy to sepolia

1. Create test wallet using keystore. Enter private key of test wallet when prompted.
    ```sh
    cast wallet import Testing --interactive
    ```
    
2. Deploy to sepolia
    ```sh
    make deploy-testnet contract=NFTContract nework=sepolia
    ```

#### Deploy to mainnet
1. Create deployer wallet using keystore. Enter private key of deployer wallet when prompted.
    ```sh
    cast wallet import <KeystoreName> --interactive
    ```
    
2. Deploy to mainnet
    ```sh
    make deploy-mainnet contract=NFTContract nework=mainnet account=<KeystoreName> sender=<deployer address>
    ```

<!-- CONTRIBUTING -->

## Contributing

Contributions are what make the open source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

If you have a suggestion that would make this better, please fork the repo and create a pull request. You can also simply open an issue with the tag "enhancement".
Don't forget to give the project a star! Thanks again!

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

<!-- LICENSE -->

## License

Distributed under the MIT License. See `LICENSE` for more information.

<!-- CONTACT -->

## Contact

Nadina Oates - [@N0_crypto](https://twitter.com/N0_crypto)

Main Repository: [https://github.com/trashpirate/venus-collection](https://github.com/trashpirate/venus-collection)

Project Link: [https://nft.tastenfts.com/](https://nft.tastenfts.com/)

<!-- ACKNOWLEDGMENTS -->
<!-- ## Acknowledgments -->
