import { Blockchain, SandboxContract, TreasuryContract } from '@ton/sandbox';
import { Cell, toNano } from '@ton/core';
import { FirstTolk } from '../wrappers/FirstTolk';
import '@ton/test-utils';
import { compile } from '@ton/blueprint';

describe('FirstTolk', () => {
    let code: Cell;

    beforeAll(async () => {
        code = await compile('FirstTolk');
    });

    let blockchain: Blockchain;
    let deployer: SandboxContract<TreasuryContract>;
    let firstTolk: SandboxContract<FirstTolk>;

    beforeEach(async () => {
        blockchain = await Blockchain.create();

        firstTolk = blockchain.openContract(FirstTolk.createFromConfig({}, code));

        deployer = await blockchain.treasury('deployer');

        const deployResult = await firstTolk.sendDeploy(deployer.getSender(), toNano('0.05'));

        expect(deployResult.transactions).toHaveTransaction({
            from: deployer.address,
            to: firstTolk.address,
            deploy: true,
            success: true,
        });
    });

    it('should deploy', async () => {
        // the check is done inside beforeEach
        // blockchain and firstTolk are ready to use
    });
});
