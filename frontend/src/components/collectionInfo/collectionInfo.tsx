"use client";
import React, { useEffect, useState } from "react";
import { useContractRead, useNetwork } from "wagmi";

import { nftABI } from "@/assets/nftABI";

import Image from "next/image";
import CopyToClipboard from "../copyToClipboard";
const NFT_CONTRACT = process.env.NEXT_PUBLIC_NFT_CONTRACT as `0x${string}`;

type Props = {};

export default function CollectionInfo({}: Props) {
  const [totalSupply, setTotalSupply] = useState<number | undefined>(undefined);

  // get chain
  const { chain } = useNetwork();

  // define token contract config
  const nftContract = {
    address: NFT_CONTRACT,
    abi: nftABI,
    chainId: chain?.id,
  };

  // read current limits
  const { data, isSuccess, isError, isLoading } = useContractRead({
    ...nftContract,
    functionName: "totalSupply",
    watch: true,
    cacheTime: 1000,
  });

  useEffect(() => {
    if (data != undefined) {
      setTotalSupply(Number(data));
    }
  }, [data]);

  function getTotalSupplyString() {
    let text: string = "---";
    if (isLoading) {
      text = "Loading...";
    } else if (isSuccess && totalSupply != undefined) {
      text = `${totalSupply.toLocaleString()}`;
    } else {
      text = "---";
    }
    return text;
  }

  function getNftsRemainingString() {
    let text: string = "---";
    if (isLoading) {
      text = "Loading...";
    } else if (isSuccess && totalSupply != undefined) {
      text = `${(10000 - totalSupply).toLocaleString()}`;
    } else {
      text = "---";
    }
    return text;
  }

  return (
    <div className="mx-auto w-full pb-8">
      <div className="mx-auto max-w-sm rounded-md bg-black p-8  shadow-inner-sym md:max-w-none">
        <h2 className="mb-4 border-b-2 border-yellow-500 pb-2 text-xl">
          VENUS COLLECTION
        </h2>
        <div className="pb-4 text-sm text-slate-600">
          <p>Contract:</p>
          <CopyToClipboard text={NFT_CONTRACT} copyText={NFT_CONTRACT} />
        </div>
        <div className="mr-16  pb-4 text-xs text-yellow-800">
          <table className="talbe-fixed w-full text-left">
            <thead>
              <tr>
                <th>TRAITS</th>
                <th>RARITY</th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <td>BLACK</td>
                <td>7.50 %</td>
              </tr>
              <tr>
                <td>BLUE</td>
                <td>0.15 %</td>
              </tr>
              <tr>
                <td>PURPLE</td>
                <td>0.075 %</td>
              </tr>
              <tr>
                <td>PINK</td>
                <td>0.02 %</td>
              </tr>
              <tr>
                <td>RED</td>
                <td>0.005 %</td>
              </tr>
            </tbody>
          </table>
        </div>
        <div className="flex justify-between">
          <h3>NFTs minted: </h3>
          <p>{getTotalSupplyString()}</p>
        </div>
        <div className="flex justify-between">
          <h3>NFTs remaining: </h3>
          <p>{getNftsRemainingString()}</p>
        </div>
      </div>
    </div>
  );
}
