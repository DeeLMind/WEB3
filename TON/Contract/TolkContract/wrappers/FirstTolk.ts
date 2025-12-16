import {
    Address,
    beginCell,
    Cell,
    Contract,
    ContractABI,
    contractAddress,
    ContractProvider,
    Sender,
    SendMode
} from '@ton/core';

export type FirstTolkConfig = {};

export function firstTolkConfigToCell(config: FirstTolkConfig): Cell {
    return beginCell().endCell();
}

export class FirstTolk implements Contract {
    abi: ContractABI = { name: 'FirstTolk' }

    constructor(readonly address: Address, readonly init?: { code: Cell; data: Cell }) {}

    static createFromAddress(address: Address) {
        return new FirstTolk(address);
    }

    static createFromConfig(config: FirstTolkConfig, code: Cell, workchain = 0) {
        const data = firstTolkConfigToCell(config);
        const init = { code, data };
        return new FirstTolk(contractAddress(workchain, init), init);
    }

    async sendDeploy(provider: ContractProvider, via: Sender, value: bigint) {
        await provider.internal(via, {
            value,
            sendMode: SendMode.PAY_GAS_SEPARATELY,
            body: beginCell().endCell(),
        });
    }
}
