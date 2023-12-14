import "./globals.css";
import type { Metadata } from "next";
import { Inter } from "next/font/google";
import { Providers } from "./providers";

const inter = Inter({ subsets: ["latin"] });

export const metadata: Metadata = {
  title: "VENUS Collection",
  description:
    "The VENUS Collection captures the essence of desire and beauty in a fleeting moment, each piece is a timeless celebration of allure and elegance. Own a piece of ethereal grace with VENUS NFTs.",
  applicationName: "Venus Collection",
  twitter: {
    card: "summary_large_image",
    site: "nft.tastenfts.com",
    creator: "TasteNFT",
    images: "https://nft.tastenfts.com/featured_image.jpg",
  },
  openGraph: {
    type: "website",
    url: "https://nft.tastenfts.com",
    title: "VENUS Collection",
    description:
      "The VENUS Collection captures the essence of desire and beauty in a fleeting moment, each piece is a timeless celebration of allure and elegance. Own a piece of ethereal grace with VENUS NFTs.",
    siteName: "Venus Collection",
    images: [
      {
        url: "https://nft.tastenfts.com/featured_image.jpg",
      },
    ],
  },
};

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <html lang="en">
      <body className="font-body">
        <Providers>{children}</Providers>
      </body>
    </html>
  );
}
