# [WEB3](https://deelmind.com)

* https://www.deelmind.com/
* https://bilibili.deelmind.com
* https://youtube.com/DeeLMind

## No Contract

| 链名                   | 特点                                             | 是否支持智能合约               |
| ---------------------- | ------------------------------------------------ | ------------------------------ |
| **Bitcoin (BTC)**      | 最早，使用 Script 脚本（非图灵完备）             | ❌                             |
| **Litecoin (LTC)**     | BTC 分叉，无合约能力                             | ❌                             |
| **Bitcoin Cash (BCH)** | 扩容版 BTC                                       | ❌                             |
| **Dogecoin (DOGE)**    | Litecoin 改版币                                  | ❌                             |
| **Monero (XMR)**       | 匿名币，无 VM                                    | ❌                             |
| **Zcash (ZEC)**        | 零知识证明保护隐私                               | ❌                             |
| **Nano (XNO)**         | 基于 block-lattice，主打快速交易                 | ❌                             |
| **Grin / Beam**        | MimbleWimble 协议实现，无合约                    | ❌                             |
| **Dash**               | 有简单脚本用于 masternode 等操作                 | ❌                             |
| **Decred (DCR)**       | 混合 PoW/PoS，无智能合约 VM                      | ❌                             |
| **Verge (XVG)**        | 匿名币系列之一，无合约能力                       | ❌                             |
| **Ravencoin (RVN)**    | 可发资产，但无通用合约                           | ❌                             |
| **Kaspa (KAS)**        | GhostDAG 算法，极致并行链                        | ❌                             |
| **Ergo (ERG)**         | 使用 Sigma Protocol，支持复杂逻辑但不使用传统 VM | ⚠️（形式上支持，逻辑不一样） |

## LiteContract

| 链名                | 特点                                 | 是否支持智能合约                |
| ------------------- | ------------------------------------ | ------------------------------- |
| **Ripple (XRP)**    | 有 Hooks 扩展、非图灵完备            | ⚠️ 限制型                     |
| **Stellar (XLM)**   | 仅限原生操作（支付、挂单、信任线等） | ⚠️ 限制型（Soroban 正在测试） |
| **Algorand (ALGO)** | TEAL 语言，有限状态机                | ⚠️ 非传统 VM                  |
| **IOTA (旧版)**     | Tangle 架构早期版本无智能合约        | ⚠️（IOTA 2.0 开始支持）       |
| **Celo（早期）**    | 类似 EVM，但初期版本功能受限         | ✅（已全面兼容）                |


## With Contract

| 链名称                  | 官网                                                     | 合约语言          | 虚拟机             | ETH 兼容性   | Layer 类型            |
| ----------------------- | -------------------------------------------------------- | ----------------- | ------------------ | ------------ | --------------------- |
| **Ethereum**            | [ethereum.org](https://ethereum.org)                     | Solidity, Vyper   | EVM                | ✅ 原生      | Layer1                |
| **BNB Smart Chain**     | [bnbchain.org](https://bnbchain.org)                     | Solidity          | EVM                | ✅           | Layer1                |
| **Polygon PoS**         | [polygon.technology](https://polygon.technology)         | Solidity          | EVM                | ✅           | Layer1                |
| **Polygon zkEVM**       | [polygon.technology](https://polygon.technology)         | Solidity          | zkEVM              | ✅           | Layer2                |
| **Arbitrum One**        | [arbitrum.io](https://arbitrum.io)                       | Solidity          | EVM                | ✅           | Layer2                |
| **Optimism**            | [optimism.io](https://optimism.io)                       | Solidity          | EVM                | ✅           | Layer2                |
| **Base (Coinbase)**     | [base.org](https://base.org)                             | Solidity          | EVM                | ✅           | Layer2                |
| **zkSync Era**          | [zksync.io](https://zksync.io)                           | Solidity          | zkEVM              | ✅           | Layer2                |
| **Scroll**              | [scroll.io](https://scroll.io)                           | Solidity          | zkEVM              | ✅           | Layer2                |
| **Linea**               | [linea.build](https://linea.build)                       | Solidity          | zkEVM              | ✅           | Layer2                |
| **Avalanche (C-Chain)** | [avax.network](https://avax.network)                     | Solidity          | EVM                | ✅           | Layer1                |
| **Fantom**              | [fantom.foundation](https://fantom.foundation)           | Solidity          | EVM                | ✅           | Layer1                |
| **Celo**                | [celo.org](https://celo.org)                             | Solidity          | EVM                | ✅           | Layer1                |
| **Cronos**              | [cronos.org](https://cronos.org)                         | Solidity          | EVM                | ✅           | Layer1                |
| **Moonbeam**            | [moonbeam.network](https://moonbeam.network)             | Solidity          | EVM (on Substrate) | ✅           | Layer1                |
| **Gnosis Chain**        | [gnosis.io](https://www.gnosis.io)                       | Solidity          | EVM                | ✅           | Layer1                |
| **Kava EVM**            | [kava.io](https://kava.io)                               | Solidity          | EVM                | ✅           | Layer1                |
| **Meter**               | [meter.io](https://www.meter.io)                         | Solidity          | EVM                | ✅           | Layer1                |
| **Metis**               | [metis.io](https://www.metis.io)                         | Solidity          | EVM                | ✅           | Layer2                |
| **Boba Network**        | [boba.network](https://boba.network)                     | Solidity          | EVM                | ✅           | Layer2                |
| **Mantle**              | [mantle.xyz](https://www.mantle.xyz/)             | Solidity          | EVM                | ✅           | Layer2                |
| **Zora**                | [zora.energy](https://zora.energy)                       | Solidity          | EVM                | ✅           | Layer2                |
| **Rootstock (RSK)**     | [rootstock.io](https://rootstock.io)                     | Solidity          | EVM                | ✅           | Layer2（Bitcoin侧链） |
| **Partisia Blockchain** | [partisiablockchain.com](https://partisiablockchain.com) | Solidity, MPC DSL | EVM + MPC          | ✅（带扩展） | Layer1                |
| **Aurora**              | [aurora.dev](https://aurora.dev)                         | Solidity          | EVM (on NEAR)      | ✅           | Layer2（on NEAR）     |



| 链名称                          | 官网                                         | 合约语言             | 虚拟机              | ETH 兼容性 | Layer 类型 |
| ------------------------------- | -------------------------------------------- | -------------------- | ------------------- | ---------- | ---------- |
| **Solana**                      | [solana.com](https://solana.com)             | Rust, C              | BPF                 | ❌         | Layer1     |
| **Sui**                         | [sui.io](https://sui.io)                     | Move                 | MoveVM              | ❌         | Layer1     |
| **Aptos**                       | [aptos.dev](https://aptos.dev)               | Move                 | MoveVM              | ❌         | Layer1     |
| **NEAR**                        | [near.org](https://near.org)                 | Rust, AssemblyScript | WASM                | ❌         | Layer1     |
| **Cosmos SDK 链（+ CosmWasm）** | [cosmos.network](https://cosmos.network)     | Rust                 | CosmWasm            | ❌         | Layer1     |
| **Osmosis**                     | [osmosis.zone](https://osmosis.zone)         | Rust                 | CosmWasm            | ❌         | Layer1     |
| **Injective**                   | [injective.com](https://injective.com)       | Rust                 | CosmWasm            | ❌         | Layer1     |
| **Juno**                        | [junonetwork.io](https://junonetwork.io)     | Rust                 | CosmWasm            | ❌         | Layer1     |
| **Secret Network**              | [scrt.network](https://scrt.network)         | Rust                 | CosmWasm (加密支持) | ❌         | Layer1     |
| **Polkadot**                    | [polkadot.network](https://polkadot.network) | Ink!, Rust           | WASM                | ❌         | Layer1     |
| **Kusama**                      | [kusama.network](https://kusama.network)     | Ink!, Rust           | WASM                | ❌         | Layer1     |
| **Cardano**                     | [cardano.org](https://cardano.org)           | Plutus (Haskell)     | PlutusVM            | ❌         | Layer1     |
| **Tezos**                       | [tezos.com](https://tezos.com)               | Michelson, LIGO      | MichelsonVM         | ❌         | Layer1     |
| **TON**                         | [ton.org](https://ton.org)                   | FunC, Tact           | TVM                 | ❌         | Layer1     |
| **ICP / Internet Computer**     | [dfinity.org](https://dfinity.org)           | Motoko, Rust         | WASM                | ❌         | Layer1     |
| **Vaulta (前 EOS)**             | [vaulta.org](https://vaulta.org)             | C++                  | EOSIO VM            | ❌         | Layer1     |


## 其它框架

| 功能 / 公链         | Ethereum  | Solana         | Sui               |
| ------------------- | --------- | -------------- | ----------------- |
| **AMM 交易所**      | Uniswap   | Orca, Raydium  | Cetus, Turbos     |
| **聚合 DEX**        | 1inch     | Jupiter        | Aftermath（初期） |
| **借贷协议**        | Aave      | Solend         | Scallop           |
| **流动性质押**      | Lido      | Marinade, Jito | Navis             |
| **永续合约 / 杠杆** | GMX, dYdX | Mango, Drift   | KriyaDEX          |
| **稳定币协议**      | MakerDAO  | UXD Protocol   | TBD（开发中）     |