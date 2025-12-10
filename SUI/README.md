# SUI

## Installation

> https://docs.sui.io/guides/developer/getting-started/sui-install

### suiup

> https://github.com/MystenLabs/suiup

* curl -sSfL https://raw.githubusercontent.com/Mystenlabs/suiup/main/install.sh | sh
* suiup install sui@testnet
* suiup install sui@devnet
* suiup install sui@mainnet

### walrus

* suiup install walrus -y

### mvr

* suiup install mvr

## sui

* ~/.sui/sui_config/client.yaml

```
active_address: "0x你的地址"
active_env: "localnet"

keystore:
  File: "/Users/xxx/.sui/sui_config/sui.keystore"

envs:
  localnet:
    rpc: "http://127.0.0.1:9000"
    ws: "ws://127.0.0.1:9000"
    faucet_url: ""

  devnet:
    rpc: "https://fullnode.devnet.sui.io"
    ws: "wss://fullnode.devnet.sui.io"
    faucet_url: "https://faucet.devnet.sui.io/gas"

  testnet:
    rpc: "https://fullnode.testnet.sui.io"
    ws: "wss://fullnode.testnet.sui.io"
    faucet_url: "https://faucet.testnet.sui.io/gas"

telemetry_enabled: false
```

* sui client new-env --alias local --rpc http://127.0.0.1:9000
* sui client switch --env localnet
* sui client switch --env testnet
