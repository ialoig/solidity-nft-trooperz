const hre = require("hardhat");
const trooperzData = require("../data/trooperz-data.json");

async function main() {
  // We get the contract to deploy
  let trooperzBase = await hre.ethers.getContractFactory("TrooperzBase");
  let trooperzFactory = await hre.ethers.getContractFactory("TrooperzFactory");
  let trooperzTraitFactory = await hre.ethers.getContractFactory(
    "TrooperzTraitFactory"
  );
  let trooperzTypes = await hre.ethers.getContractFactory("TrooperzTypes");

  console.log("\n\n------> START: Deploying contracts...");
  trooperzBase = await trooperzBase.deploy();
  trooperzFactory = await trooperzFactory.deploy();
  trooperzTraitFactory = await trooperzTraitFactory.deploy();
  trooperzTypes = await trooperzTypes.deploy();

  await trooperzBase.deployed();
  await trooperzFactory.deployed();
  await trooperzTraitFactory.deployed();
  await trooperzTypes.deployed();
  console.log("TrooperzBase deployed to:", trooperzBase.address);
  console.log("TrooperzFactory deployed to:", trooperzFactory.address);
  console.log(
    "TrooperzTraitFactory deployed to:",
    trooperzTraitFactory.address
  );
  console.log("TrooperzTypes deployed to:", trooperzTypes.address);

  console.log("------> END: Deploying contracts...");

  console.log("\n\n------> START: Adding traits ....");
  for (const { index, traits } of trooperzData) {
    console.log("traits length:", traits.length);
    for (let i = 0; i < traits.length; i++) {
      const trait = await trooperzTraitFactory.createTrait(
        traits[i].category,
        traits[i].name,
        traits[i].season,
        traits[i].svg
      );
      // console.log("Trait created: %s", trait) ;
      console.log(
        "trooperz trait added [%s]:",
        i,
        "{",
        traits[i].category,
        traits[i].name,
        traits[i].season,
        traits[i].svg,
        "}"
      );
    }
  }
  console.log("------> END: Adding traits ....");

  let trait = await trooperzTraitFactory.getTrait(0, 1);
  console.log("getTrait category 0: ", trait);
  trait = await trooperzTraitFactory.getTrait(1, 1);
  console.log("getTrait category 1: ", trait);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
