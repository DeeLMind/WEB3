// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import "forge-std/Test.sol";

contract SelectorTest is Test {
    function testPrintSelector() public {
        bytes32 encode_s = keccak256("testPrintSelector()");
        bytes4 selector = bytes4(encode_s);
        console.logBytes4(selector);
        console.logBytes32(encode_s);
    }
}