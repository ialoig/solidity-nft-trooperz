const hre = require("hardhat");
const trooperzData = require("../data/trooperz-data.json");

async function main() {
  // We get the contract to deploy
  let trooperzLibrary = await hre.ethers.getContractFactory("TrooperzLibrary");
  trooperzLibrary = await trooperzLibrary.deploy();
  await trooperzLibrary.deployed();
  let trooperzTypes = await hre.ethers.getContractFactory("TrooperzTypes");

  console.log("\n\n------> START: Deploying contracts...");
  // let trooperzBase = await hre.ethers.getContractFactory("TrooperzBase", {
  //   libraries: {
  //     TrooperzLibrary: trooperzLibrary.address,
  //   },
  // });
  let trooperzBase = await hre.ethers.getContractFactory("TrooperzBase");
  trooperzBase = await trooperzBase.deploy();
  trooperzTypes = await trooperzTypes.deploy();

  await trooperzBase.deployed();
  await trooperzTypes.deployed();
  console.log("TrooperzBase deployed to:", trooperzBase.address);
  console.log("TrooperzFactory deployed to:", trooperzLibrary.address);
  console.log("TrooperzTypes deployed to:", trooperzTypes.address);

  console.log("------> END: Deploying contracts...");

  console.log("\n\n------> START: Adding traits ....");
  console.log("n.%d traits to be loaded", trooperzData.length);
  for (const { indexTrait, traits } of trooperzData) {
    console.log("loading trait [%s]", indexTrait);
    for (let i = 0; i < traits.length; i++) {
      await trooperzBase.createTrait(
        traits[i].category,
        traits[i].name,
        traits[i].season,
        traits[i].svg
      );
      // console.log(
      //   "trooperz trait added [%s]:",
      //   i,
      //   "{",
      //   traits[i].category,
      //   traits[i].name,
      //   traits[i].season,
      //   traits[i].svg,
      //   "}"
      // );
    }
  }
  console.log("------> END: Adding traits ....");

  // const trait = await trooperzTraitFactory.getTrait(0, 1);
  // console.log("getTrait category 0: ", trait);
  // trait = await trooperzTraitFactory.getTrait(1, 1);
  // console.log("getTrait category 1: ", trait);

  console.log("\n\n------> START: Generating Trooperz ....");
  const svg = await trooperzBase.mintTrooperz();
  console.log("generated svg: ", svg);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
