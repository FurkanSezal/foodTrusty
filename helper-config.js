const { ethers } = require("hardhat");

const networkConfig = {
  5: {
    name: "goerli",
    enteranceFee: ethers.utils.parseEther("0.01"),
    daoPercentage: "10",
  },
  80001: {
    name: "mumbai",
    enteranceFee: ethers.utils.parseEther("0.01"),
    daoPercentage: "10",
  },
  31337: {
    name: "hardhat",
    enteranceFee: ethers.utils.parseEther("0.01"),
    daoPercentage: "10",
  },
};

const developmentChains = ["hardhat", "localhost"];

module.exports = {
  developmentChains,
  networkConfig,
};
