const registerMeter = artifacts.require("./registerNode.sol");
const orderBook = artifacts.require("./PowerGridTransaction.sol");

module.exports = function(deployer) {
  deployer.deploy(registerNode);
  deployer.deploy(PowerGridTransaction);
};
