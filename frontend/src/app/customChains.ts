export const binanceChain = {
  id: 56,
  name: "BinanceChain",
  nativeCurrency: {
    decimals: 18,
    name: "Binance",
    symbol: "BNB",
  },
  rpcUrls: {
    default: "https://rpc.ankr.com/bsc",
  },
  blockExplorers: {
    default: { name: "BscScan", url: "https://bscscan.com" },
    bscScan: { name: "BscScan", url: "https://bscscan.com" },
  },
  testnet: false,
};

export const binanceChainTestnet = {
  id: 97,
  name: "BscTestnet",
  nativeCurrency: {
    decimals: 18,
    name: "BinanceTestnet",
    symbol: "tBNB",
  },
  rpcUrls: {
    default: "https://rpc.ankr.com/bsc_testnet_chapel",
  },
  blockExplorers: {
    default: { name: "BscScanTestnet", url: "https://testnet.bscscan.com" },
    bscScan: { name: "BscScanTestnet", url: "https://testnet.bscscan.com" },
  },
  testnet: true,
};
