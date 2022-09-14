require("@nomiclabs/hardhat-waffle");
require("@nomiclabs/hardhat-etherscan");

var INFURA_KEY = "4913daa7178a4c77823ddea002c39d00";
const mnemonic = "student wrap youth couple scheme endless seat build purse negative pole egg";

module.exports = {
  defaultNetwork: "rinkeby",
  networks: {
    hardhat: {
    },
    rinkeby: {
      accounts: ["6f5603689e90135ca898128ff38ae5940abb68cd8960c9491769bd6215380afb"],
      url: `https://rinkeby.infura.io/v3/${INFURA_KEY}`,
      gasPrice: "auto",
    },
    bsctestnet: {
      url: "https://data-seed-prebsc-1-s1.binance.org:8545",
      chainId: 97,
      gasPrice: 20000000000,
      accounts: { mnemonic: mnemonic }
    },
    bscmainnet: {
      url: "https://bsc-dataseed.binance.org/",
      chainId: 56,
      gasPrice: 20000000000,
      accounts: { mnemonic: mnemonic }
    }
  },
  etherscan: {
    // Your API key for Etherscan
    // Obtain one at https://etherscan.io/
    apiKey: "11454F2XH7YASC1DV8TVUIJ24DI51N1HC3"
  },
  solidity: {
    compilers: [
      {
        version: "0.6.12",
        settings: {
          optimizer: {
            enabled: true,
            runs: 200
          }
        }
      }
    ],
  },
  paths: {
    sources: "./contracts",
    tests: "./test",
    cache: "./cache",
    artifacts: "./artifacts"
  },
  mocha: {
    timeout: 20000
  }
}