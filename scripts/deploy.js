// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// When running the script with `npx hardhat run <script>` you'll find the Hardhat
// Runtime Environment's members available in the global scope.
const hre = require("hardhat");

async function main() {
  // Hardhat always runs the compile task when running scripts with its command
  // line interface.
  //
  // If this script is run directly using `node` you may want to call compile
  // manually to make sure everything is compiled
  // await hre.run('compile');

  // We get the contract to deploy

  const MasterWizard = await hre.ethers.getContractFactory("MasterWizard");
  const masterWizard = await MasterWizard.deploy(
    "0x8e33A77a1B257E04f8cF09CF2D50F49662B96651", // Cake Token
    "0x2DbC4e3885C3605d92F6cb0Be067AC92a75750aD", // Syrup Token
    "0xd733Dea83fFf749aEa99bbA541F6F1157A9Cb588", //Dev Address
    100,
    0
  );

  await masterWizard.deployed();

  console.log("MasterWizard deployed to:", masterWizard.address);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
