# Foundry

## forge
* forge init hello_foundry
* forge build
* forge script .\script\deploy.sol --rpc-url https://nodes.onlypwner.xyz/rpc/2960134a-4ad3-4dd1-b150-9a54591f8c01 --private-key be0a5d9f38057fa406c987fd1926f7bfc49f094dc4e138fc740665d179e6a56a --broadcast



* address(uint160(uint256(keccak256('hevm cheat code')))); 0x7109709ECfa91a80626fF3989D68f67F5b1DD12D

## cast
* cast call 0x5FbDB2315678afecb367f032d93F642f64180aa3 "helloworld()" --rpc-url http://127.0.0.1:8545
* cast call 0x5FbDB2315678afecb367f032d93F642f64180aa3 "helloworld(string,uint256)" "DeeLMind" 123 --rpc-url http://127.0.0.1:8545
* cast call 0x5FbDB2315678afecb367f032d93F642f64180aa3 "addr()" --rpc-url http://127.0.0.1:8545
* cast call 0x5FbDB2315678afecb367f032d93F642f64180aa3 "addr()" --rpc-url http://127.0.0.1:8545 --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80 --value 1ether
* cast calldata "setValue(uint256)" 10
* cast abi-decode "str()(string)" 0x0000000000000000000000000000000000000000000000000000000000000020000000000000000000000000000000000000000000000000000000000000000b48656c6c6f20576f726c64000000000000000000000000000000000000000000
* cast keccak "transfer(address,uint256)"
* cast sig "example()"
* forge test --match-path test/Selector.t.sol --match-test testPrintSelector -vvvv
* forge test --match-path test/Selector.t.sol -vvvv
* forge test --contracts test/Selector.t.sol -vvvv
* cast calldata-decode "inspect(string memory arg)" 0xaaa


## anvil

| 参数                    | 说明                         | 示例                                                                               |
| --------------------- | -------------------------- | -------------------------------------------------------------------------------- |
| `--port`              | 自定义 RPC 端口                 | `anvil --port 8546`                                                              |
| `--host`              | 自定义监听地址                    | `anvil --host 0.0.0.0`                                                           |
| `--block-time`        | 自动出块时间（秒）                  | `anvil --block-time 3`                                                           |
| `--fork-url`          | 指定链 ID 和 RPC URL，进行主网 Fork | `anvil --fork-url https://mainnet.infura.io/v3/your-key`                         |
| `--fork-block-number` | 指定 Fork 的区块高度              | `anvil --fork-url ... --fork-block-number 18000000`                              |
| `--chain-id`          | 自定义链 ID                    | `anvil --chain-id 1337`                                                          |
| `--mnemonic`          | 指定助记词                      | `anvil --mnemonic "test test test test test test test test test test test junk"` |
| `--accounts`          | 生成账户数量                     | `anvil --accounts 20`                                                            |
| `--balance`           | 每个账户初始余额                   | `anvil --balance 10000`                                                          |
| `--gas-price`         | 指定固定 gas price             | `anvil --gas-price 1000000000`                                                   |
| `--no-mining`         | 禁用自动出块（需手动出块）              | `anvil --no-mining`                                                              |
| `--silent`            | 不打印日志                      | `anvil --silent`                                                                 |
| `--dump-state`        | 导出当前状态为 JSON               | `anvil --dump-state state.json`                                                  |


# Hardhat

npx hardhat node
npx hardhat init
npx hardhat compile
npx hardhat ignition deploy .\ignition\modules\Lock.js --network localhost