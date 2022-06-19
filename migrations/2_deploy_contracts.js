const registerMeter = artifacts.require("./registerNode.sol");
const orderBook = artifacts.require("./PowerTradingTransaction.sol");

module.exports = function(deployer) {
  deployer.deploy(registerNode);
  deployer.deploy(PowerTradingTransaction);
};
