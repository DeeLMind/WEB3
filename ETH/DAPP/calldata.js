// 引入 web3.js
import Web3 from 'web3';

// 连接 RPC 节点（本地节点、Anvil、Ganache、Hardhat Node 都可以）
const web3 = new Web3('http://localhost:8545');

// 合约地址
const contractAddress = '0x5fbdb2315678afecb367f032d93f642f64180aa3';

// web3.eth.call({
//   to: contractAddress,
//   data: "0xfed0ac47"
// }).then(console.log);

const calldata = web3.eth.abi.encodeFunctionCall({
  name: "inspectTxAndGas",
  type: "function",
  outputs: [{"type":"string"}]
});

console.log(calldata);

const tx = {
  from: "0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266",
  to: contractAddress,
  data: calldata,
  gas: 1000000
};

web3.eth.sendTransaction(tx).then(console.log);
