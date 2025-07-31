// 引入 ethers.js 库
const { Wallet } = require('ethers');

// 助记词（通常由 12 或 24 个单词组成）
const mnemonic = '';

// 使用助记词恢复钱包
const wallet = Wallet.fromPhrase(mnemonic);

// 输出钱包的地址和私钥
console.log('地址:', wallet.address);
console.log('私钥:', wallet.privateKey);


