import { toNano } from '@ton/core';
import { FirstFunC } from '../wrappers/FirstFunC';
import { compile, NetworkProvider } from '@ton/blueprint';

export async function run(provider: NetworkProvider) {
    const firstFunC = provider.open(
        FirstFunC.createFromConfig(
            {
                id: Math.floor(Math.random() * 10000),
                counter: 0,
            },
            await compile('FirstFunC')
        )
    );

    await firstFunC.sendDeploy(provider.sender(), toNano('0.05'));

    await provider.waitForDeploy(firstFunC.address);

    console.log('ID', await firstFunC.getID());
}
