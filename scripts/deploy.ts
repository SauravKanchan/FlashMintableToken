import { Contract, ContractFactory } from "ethers";
// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
// When running the script with `hardhat run <script>` you'll find the Hardhat
// Runtime Environment's members available in the global scope.
import { ethers } from "hardhat";
import { FlashMinter__factory, FlashWETH__factory } from "../typechain"

async function main(): Promise<void> {
  const FlashWETH = (await ethers.getContractFactory("FlashWETH")) as FlashWETH__factory;
  const flashWeth = await FlashWETH.deploy();

  console.log(`Flash Wrapped ether deployed to: ${flashWeth.address}`);

  const FlashMinter = (await ethers.getContractFactory("FlashMinter")) as FlashMinter__factory;

  const flashMinter = await FlashMinter.deploy(flashWeth.address)
  console.log(`Flash Minter deployed to: ${flashMinter.address}`);

  const tx = await flashWeth.flashMint(flashMinter.address, ethers.utils.parseEther("100"), [])

  await tx.wait();

  const amountMinted = await flashMinter.totalBorrowed();
 
  console.log("Flash Minted account", amountMinted.toNumber())
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch((error: Error) => {
    console.error(error);
    process.exit(1);
  });
