import { toNano } from '@ton/core';
import { FirstTact } from '../build/FirstTact/FirstTact_FirstTact';
import { NetworkProvider } from '@ton/blueprint';

export async function run(provider: NetworkProvider) {
    const firstTact = provider.open(await FirstTact.fromInit());

    await firstTact.send(
        provider.sender(),
        {
            value: toNano('0.05'),
        },
        null,
    );

    await provider.waitForDeploy(firstTact.address);

    // run methods on `firstTact`
}
