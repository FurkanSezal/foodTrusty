const { getNamedAccounts, deployments, network, ethers } = require("hardhat");
const { developmentChains } = require("../helper-config");
const { verify } = require("../utils/verify");

module.exports = async ({ getNamedAccounts, deployments }) => {
  const { deploy, log } = deployments;
  const { deployer } = await getNamedAccounts();

  args = [];
  const foodTrusty = await deploy("foodTrusty", {
    from: deployer,
    args: args,
    log: true,
    waitConfirmations: network.config.blockConfirmations || 1,
  });
  log(`foodTrusty deployed at ${foodTrusty.address}`);

  if (
    !developmentChains.includes(network.name) &&
    process.env.ETHERSCAN_API_KEY
  ) {
    await verify(foodTrusty.address, args);
  }
};
module.exports.tags = ["all"];
