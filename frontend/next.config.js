/** @type {import('next').NextConfig} */

const nextConfig = {
  reactStrictMode: true,
  webpack: (config) => {
    config.resolve.fallback = { fs: false, net: false, tls: false };
    config.externals.push("pino-pretty", "lokijs", "encoding");
    return config;
  },
  images: {
    domains: [
      "bafybeihdbdvxhpn3ckfan6vkrg6iak6waro23a4pcckq3th35nrjjdswxm.ipfs.nftstorage.link",
    ],
  },
};

module.exports = nextConfig;
