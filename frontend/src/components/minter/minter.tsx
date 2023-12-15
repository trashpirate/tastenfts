"use client";
import { nftABI } from "@/assets/nftABI";
import { tokenABI } from "@/assets/tokenABI";
import React, { useEffect, useState } from "react";
import Image from "next/image";

import { parseUnits } from "viem";
import {
  useAccount,
  useContractReads,
  useContractWrite,
  useNetwork,
  usePrepareContractWrite,
  useWaitForTransaction,
} from "wagmi";

const NFT_CONTRACT = process.env.NEXT_PUBLIC_NFT_CONTRACT as `0x${string}`;
const TOKEN_CONTRACT = process.env.NEXT_PUBLIC_TOKEN_CONTRACT as `0x${string}`;
const NFT_FEE = 20000000000;

type Props = {};

export default function Minter({}: Props) {
  const [quantity, setQuantity] = useState<string>("1");
  const [transferAmount, setTransferAmount] = useState<bigint>(
    parseUnits(NFT_FEE.toString(), 9),
  );
  const [approvedAmount, setApprovedAmount] = useState<bigint | undefined>(
    undefined,
  );
  const [tokenBalance, setTokenBalance] = useState<bigint | undefined>(
    undefined,
  );
  const [nftBalance, setNftBalance] = useState<number | undefined>(undefined);
  const [maxPerWallet, setMaxPerWallet] = useState<number>(2);
  const [batchLimit, setBatchLimit] = useState<number>(0);
  const [buttonText, setButtonText] = useState<string>("MINT");

  const [imagePath, setImagePath] = useState<string>("/logo.png");
  const [message, setMessage] = useState<string>(
    "Mint an NFT and win a prize!",
  );

  // get account address
  const { address, isConnecting, isDisconnected, isConnected } = useAccount({});

  // get chain
  const { chain } = useNetwork();

  // define token contract config
  const tokenContract = {
    address: TOKEN_CONTRACT,
    abi: tokenABI,
    chainId: chain?.id,
  };

  // define token contract config
  const nftContract = {
    address: NFT_CONTRACT,
    abi: nftABI,
    chainId: chain?.id,
  };

  // read token info
  const {
    data: accountData,
    isError: isAccountError,
    isLoading: isAccountLoading,
  } = useContractReads({
    contracts: [
      {
        ...tokenContract,
        functionName: "balanceOf",
        args: [address as `0x${string}`],
      },
      {
        ...tokenContract,
        functionName: "allowance",
        args: [address as `0x${string}`, NFT_CONTRACT],
      },
    ],
    enabled: isConnected && address != null,
    watch: true,
  });

  // read nft balance
  const {
    data: nftData,
    isError: isNftError,
    isLoading: isNftLoading,
  } = useContractReads({
    contracts: [
      {
        ...nftContract,
        functionName: "balanceOf",
        args: [address as `0x${string}`],
      },
      {
        ...nftContract,
        functionName: "batchLimit",
      },
      {
        ...nftContract,
        functionName: "maxPerWallet",
      },
    ],
    enabled: isConnected && address != null,
    watch: true,
  });

  useEffect(() => {
    if (nftData != undefined) {
      setNftBalance(Number(nftData?.[0].result));
      setBatchLimit(Number(nftData?.[1].result));
      setMaxPerWallet(Number(nftData?.[2].result));
    }
  }, [nftData]);

  // approving funds
  const { config: approvalConfig } = usePrepareContractWrite({
    address: TOKEN_CONTRACT as `0x${string}`,
    abi: tokenABI,
    functionName: "approve",
    args: [NFT_CONTRACT, transferAmount],
    enabled: (Number(quantity) > 0 &&
      isConnected &&
      approvedAmount != undefined &&
      approvedAmount < transferAmount) as boolean,
  });

  const { data: approvedData, write: approve } =
    useContractWrite(approvalConfig);

  const { isLoading: approvalLoading, isSuccess: approvalSuccess } =
    useWaitForTransaction({
      confirmations: 1,
      hash: approvedData?.hash,
    });

  useEffect(() => {
    if (accountData != undefined) {
      setTokenBalance(accountData[0].result);
      setApprovedAmount(accountData[1].result);
    }
  }, [accountData]);

  // mint nfts
  const { config: mintConfig } = usePrepareContractWrite({
    ...nftContract,
    functionName: "mint",
    args: [BigInt(quantity)],
    enabled:
      Number(quantity) > 0 &&
      isConnected &&
      nftBalance != undefined &&
      nftBalance + Number(quantity) <= maxPerWallet &&
      approvedAmount != undefined &&
      approvedAmount >= transferAmount,
  });
  const {
    data: mintData,
    error: mintError,
    isError: isMintError,
    write: mint,
  } = useContractWrite(mintConfig);

  const { isLoading: isMintLoading, isSuccess: isMintSuccess } =
    useWaitForTransaction({
      confirmations: 1,
      hash: mintData?.hash,
    });

  useEffect(() => {
    if (
      approvedAmount != undefined &&
      approvedAmount >= transferAmount &&
      nftBalance != undefined &&
      nftBalance + Number(quantity) < maxPerWallet
    )
      mint?.();
  }, [approvalSuccess]);

  // update transfer amount
  useEffect(() => {
    if (Number(quantity) > 0)
      setTransferAmount(parseUnits(`${Number(quantity) * NFT_FEE}`, 9));
  }, [quantity]);

  // ============================================================================
  // display elements

  // set image path
  useEffect(() => {
    if (isMintLoading && isConnected) {
      setImagePath("/nftAnimation.gif");
    } else if (!isMintLoading && isMintSuccess && isConnected) {
      setImagePath("/featured_image.jpg");
      setMessage("Minting completed.");
    } else {
      setImagePath("/featured_image.jpg");
    }
  }, [isMintLoading, isMintSuccess]);

  useEffect(() => {
    if (isMintLoading) setButtonText("Minting...");
    else if (approvalLoading) setButtonText("Approving Funds...");
    else if (
      Number(quantity) > 0 &&
      approvedAmount != undefined &&
      approvedAmount >= transferAmount
    )
      setButtonText("CONFIRM MINT");
    else setButtonText("MINT");
  }, [
    isMintLoading,
    approvalLoading,
    approvedAmount,
    transferAmount,
    quantity,
  ]);

  function mintButton() {
    if (isDisconnected && batchLimit) {
      return <div className="mt-4">Connect your wallet to mint an NFT</div>;
    } else if (batchLimit) {
      // mint is enabled
      // =====================================================
      if (tokenBalance != undefined && tokenBalance < transferAmount) {
        return (
          <button
            className="bg-hover text-dark rounded-xl px-5 py-3"
            disabled={true}
            onClick={(e) => {}}
          >
            Insufficient Balance
          </button>
        );
      } else if (
        nftBalance != undefined &&
        nftBalance + Number(quantity) > maxPerWallet
      ) {
        // max per wallet exceeded
        return (
          <button
            className="text-dark bg-hover rounded-xl px-5 py-3"
            disabled={true}
            onClick={(e) => {}}
          >
            {`Max. ${maxPerWallet} NFTs/Wallet`}
          </button>
        );
        // TODO: no more nfts to mint
        // SOLD OUT
      } else {
        // minting enabled
        return (
          <button
            className="bg-highlight hover:bg-hover rounded-xl px-5 py-3 font-bold text-black"
            disabled={
              isMintLoading ||
              approvalLoading ||
              approvedAmount == undefined ||
              (approvedAmount >= transferAmount && !mint) ||
              ((approvedAmount == undefined ||
                approvedAmount < transferAmount) &&
                !approve)
            }
            onClick={(e) => {
              if (
                approvedAmount == undefined ||
                approvedAmount < transferAmount
              ) {
                approve?.();
              } else {
                mint?.();
              }
            }}
          >
            {buttonText}
          </button>
        );
      }
    } else {
      return <div>NFT MINT STARTS ON JANUARY 12TH</div>;
    }
  }

  function mintPanel(canMint: number) {
    if (canMint > 0) {
      return (
        <div className="pt-2">
          <div className="flex h-14 justify-center">
            <h1 className="text-accent my-auto text-center align-middle text-lg">
              {message}
            </h1>
          </div>
          <div className="my-4 justify-center text-center">
            <form>
              <label>
                Enter number of NFTs:
                <input
                  className="bg-dark mx-auto ml-2 rounded p-1 text-right"
                  type="number"
                  value={quantity}
                  max={batchLimit}
                  min="1"
                  placeholder="1"
                  onChange={(e) => {
                    setQuantity(e.target.value);
                  }}
                />
              </label>
            </form>
          </div>
          <div className="mt-2 flex justify-center">{mintButton()}</div>
        </div>
      );
    } else {
      return (
        <div className="flex-col justify-center gap-4 pt-4 text-center">
          <p className="my-8">MINT STARTS ON DEC 16TH, 1PM CST</p>
          <div className="bg-highlight hover:bg-hover mx-auto my-2 h-10 w-fit rounded-md px-4 py-2 font-bold text-black">
            <a
              className="mx-auto"
              href="https://pancakeswap.finance/swap?chain=bsc&outputCurrency=0xdB238123939637D65a03E4b2b485650B4f9D91CB"
              target={"_blank"}
            >
              <p>BUY $TASTE</p>
            </a>
          </div>
        </div>
      );
    }
  }

  return (
    <div className="mx-auto h-full w-full max-w-sm flex-col justify-between rounded-lg bg-black p-8 shadow-inner-sym md:max-w-none">
      <div className="mx-auto mb-4 w-full max-w-xs overflow-hidden rounded border-2 border-white bg-white">
        <Image
          src={imagePath}
          width={250}
          height={250}
          alt="VENUS NFTs"
          style={{
            width: "100%",
            height: "auto",
          }}
          priority
        />
        <div className="m-4">
          <div className="m-1 font-bold text-black">{"VENUS COLLECTION"}</div>
          <div className="m-1 text-black">{`${
            NFT_FEE / 1000000000
          }${String.fromCharCode(8239)}B $TASTE PER NFT`}</div>
        </div>
      </div>
      {mintPanel(batchLimit)}
    </div>
  );
}
