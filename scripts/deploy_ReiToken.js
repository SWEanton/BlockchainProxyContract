const { ethers } = require("hardhat");

async function main() {
  const [deployer] = await ethers.getSigners();

  console.log("Deploying contracts with the account:", deployer.address);

  const ReiToken = await ethers.getContractFactory("ReiToken");
  const reiToken = await ReiToken.deploy();

  console.log("ReiToken address:", reiToken.address);
}

main()
  .then(() => process.exit(0))
  .catch(error => {
    console.error(error);
    process.exit(1);
  });