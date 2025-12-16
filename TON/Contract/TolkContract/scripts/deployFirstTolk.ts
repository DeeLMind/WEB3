import { toNano } from '@ton/core';
import { FirstTolk } from '../wrappers/FirstTolk';
import { compile, NetworkProvider } from '@ton/blueprint';

export async function run(provider: NetworkProvider) {
    const firstTolk = provider.open(FirstTolk.createFromConfig({}, await compile('FirstTolk')));

    await firstTolk.sendDeploy(provider.sender(), toNano('0.05'));

    await provider.waitForDeploy(firstTolk.address);

    // run methods on `firstTolk`
}
