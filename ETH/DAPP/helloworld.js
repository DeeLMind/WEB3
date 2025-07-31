// 引入 web3.js
import Web3 from 'web3';

// 连接 RPC 节点（本地节点、Anvil、Ganache、Hardhat Node 都可以）
const web3 = new Web3('http://localhost:8545');

// 合约地址
const contractAddress = '0x5fbdb2315678afecb367f032d93f642f64180aa3';

// 输入二进制 --> EVM --> 解码 selector --> 路由到目标函数 --> 解析参数 --> 执行函数

// 合约 ABI（只包含你要调用的函数）
const abi = [
  {
    // 合约里定义的函数名
    "name": "helloworld",

    // 输出参数列表，这里表示函数返回一个 string 类型，变量名省略（可以理解为匿名返回）
    "outputs": [
      { "type": "string" }
    ],

    // 描述类型，这里表示是一个函数（ABI 还可以描述事件、构造函数等）
    "type": "function"
  }
];

// 获取合约对象
const contract = new web3.eth.Contract(abi, contractAddress);

// 调用合约函数
async function callHelloworld() {
  try {
    const result = await contract.methods.helloworld().call();
    console.log('合约返回:', result);
  } catch (error) {
    console.error('调用失败:', error);
  }
}

callHelloworld();