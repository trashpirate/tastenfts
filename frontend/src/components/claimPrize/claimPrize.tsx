import CopyToClipboard from "../copyToClipboard";
const CLAIM_ADDRESS = "0x0cf66382d52C2D6c1D095c536c16c203117E2B2f";

type Props = {};

export default function ClaimPrize({}: Props) {
  return (
    <div className="mx-auto w-full">
      <div className="mx-auto max-w-sm rounded-md bg-black p-8  shadow-inner-sym md:max-w-none">
        <h2 className="mb-4 border-b-2 border-yellow-500 pb-2 text-xl uppercase">
          About VENUS Collection
        </h2>

        <p className="text-sm font-thin">
          The VENUS Collection captures the essence of desire and beauty in a
          fleeting moment, each piece is a timeless celebration of allure and
          elegance. Own a piece of ethereal grace with VENUS NFTs.
        </p>
      </div>
    </div>
  );
}
