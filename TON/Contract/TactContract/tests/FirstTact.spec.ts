import { Blockchain, SandboxContract, TreasuryContract } from '@ton/sandbox';
import { toNano } from '@ton/core';
import { FirstTact } from '../build/FirstTact/FirstTact_FirstTact';
import '@ton/test-utils';

describe('FirstTact', () => {
    let blockchain: Blockchain;
    let deployer: SandboxContract<TreasuryContract>;
    let firstTact: SandboxContract<FirstTact>;

    beforeEach(async () => {
        blockchain = await Blockchain.create();

        firstTact = blockchain.openContract(await FirstTact.fromInit());

        deployer = await blockchain.treasury('deployer');

        const deployResult = await firstTact.send(
            deployer.getSender(),
            {
                value: toNano('0.05'),
            },
            null,
        );

        expect(deployResult.transactions).toHaveTransaction({
            from: deployer.address,
            to: firstTact.address,
            deploy: true,
            success: true,
        });
    });

    it('should deploy', async () => {
        // the check is done inside beforeEach
        // blockchain and firstTact are ready to use
    });
});
