// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

contract MsgInspector {
    function inspect(string memory arg) external payable returns (
        address sender,
        address origin,
        uint256 value,
        bytes4 sig,
        bytes memory data,
        string memory
    ) {
        bytes memory _data = msg.data;
        return (msg.sender, tx.origin, msg.value, msg.sig, _data, arg);
    }
}
