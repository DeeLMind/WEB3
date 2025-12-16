import TonWeb from "tonweb";

// 主网
const tonweb = new TonWeb(
  new TonWeb.HttpProvider("https://toncenter.com/api/v2/jsonRPC")
);

console.log(tonweb);

// 测试网
const tonwebTestnet = new TonWeb(
  new TonWeb.HttpProvider("https://testnet.toncenter.com/api/v2/jsonRPC")
);

console.log(tonwebTestnet);
