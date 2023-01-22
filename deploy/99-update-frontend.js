const { ethers, network } = require("hardhat");
const fs = require("fs");

const frontEndContractsFile = "./nextjs/constants/networkMapping.json";
const fromEndAbiLocation = "./nextjs/constants/";
module.exports = async function () {
  if (process.env.UPTADE_FRONT_END) {
    console.log("uptading front end ...");
    await updateContractAddresses();
    await uptadeAbi();
  }
};

async function uptadeAbi() {
  const foodTrusty = await ethers.getContract("foodTrusty");
  fs.writeFileSync(
    `${fromEndAbiLocation}foodTrusty.json`,
    foodTrusty.interface.format(ethers.utils.FormatTypes.json)
  );
}

async function updateContractAddresses() {
  const foodTrusty = await ethers.getContract("foodTrusty");
  const chainId = network.config.chainId.toString();

  const contractAddresses = JSON.parse(
    fs.readFileSync(frontEndContractsFile, "utf8")
  );

  if (chainId in contractAddresses) {
    if (
      !contractAddresses[chainId]["foodTrusty"].includes(foodTrusty.address)
    ) {
      contractAddresses[chainId]["foodTrusty"].push(foodTrusty.address);
    }
  } else {
    contractAddresses[chainId] = { foodTrusty: [foodTrusty.address] };
  }
  fs.writeFileSync(frontEndContractsFile, JSON.stringify(contractAddresses));
}

module.exports.tags = ["all", "frontend"];
