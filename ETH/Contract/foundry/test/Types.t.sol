// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import "forge-std/Test.sol";
import "../src/Types.sol";

contract TypesTest is Test {
    Types public typesContract;

    // 每个测试前运行，部署合约
    function setUp() public {
        typesContract = new Types();
    }

    function testIntVar() view public {
        assertEq(typesContract.intVar(), -123);
    }
}