// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

contract ContextInspector {
    // ✅ 1. 交易 & Gas 相关信息
    function inspectTxAndGas() external view returns (
        uint256 gasPrice,
        uint256 gasLeft
    ) {
        return (
            tx.gasprice,
            gasleft()
        );
    }

    // ✅ 2. 区块基础信息
    function inspectBlockBasic() external view returns (
        uint256 blockNumber,
        uint256 timestamp,
        uint256 basefee,
        uint256 blobbasefee,
        bytes32 recentBlockHash,
        uint256 chainid
    ) {
        return (
            block.number,
            block.timestamp,
            block.basefee,
            block.blobbasefee,
            blockhash(block.number - 1),
            block.chainid
        );
    }

    // ✅ 3. 区块进阶信息（矿工、gas限制、blob等）
    function inspectBlockAdvanced() external view returns (
        address coinbase,
        uint256 difficulty,
        uint256 gaslimit,
        bytes32 blobhash0,
        uint256 prevrandao
    ) {
        return (
            block.coinbase,
            block.difficulty,
            block.gaslimit,
            blobhash(0),
            block.prevrandao
        );
    }
}
