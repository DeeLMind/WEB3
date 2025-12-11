import { getFullnodeUrl, SuiClient } from '@mysten/sui/client';

async function main() {
    // 创建 Sui devnet 客户端
    const client = new SuiClient({ url: getFullnodeUrl('devnet') });

    // 查询某个地址的 coins
    const coins = await client.getCoins({
        owner: '0xcc2bd176a478baea9a0de7a24cd927661cc6e860d5bacecb9a138ef20dbab231',
    });

    // 打印结果
    console.log(JSON.stringify(coins, null, 2));
}

main().catch(console.error);
