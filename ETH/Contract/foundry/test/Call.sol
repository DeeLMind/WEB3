// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

contract Receiver {
    uint public value;

    receive() external payable {
        // console.log(msg.sender, msg.value, "receive");
    }

    fallback() external payable {
        // console.log(msg.sender, msg.value, "fallback");
    }

    function setValue(uint _value) external {
        value = _value;
        // console.log("setValue called");
    }

    function getSender() external view returns (address) {
        return msg.sender;
    }
}


contract Caller {
    event Success(bool success, bytes data);

    function transferTo(address payable to) external payable {
        to.transfer(msg.value);
    }

    function sendTo(address payable to) external payable {
        bool sent = to.send(msg.value);
        require(sent, "Send failed");
    }

    function callTo(address payable to) external payable {
        (bool success, bytes memory data) = to.call{value: msg.value, gas: 100000}("");
        // (bool success, bytes memory data) = _addr.call{value: msg.value}(
        //     abi.encodeWithSignature("setX(uint256)", x)
        // );
        emit Success(success, data);
    }

    function callFunction(address to, bytes memory data) external {
        (bool success, bytes memory result) = to.call(data);
        emit Success(success, result);
    }

    function delegateTo(address to, bytes memory data) external {
        (bool success, bytes memory result) = to.delegatecall(data);
        emit Success(success, result);
    }

    uint public value;

    function setValue(uint _value) external {
        value = _value;
    }
}


contract TransferTest is Test {
    Caller public caller;
    Receiver public receiver;

    address payable internal receiverAddr;

    function setUp() public {
        caller = new Caller();
        receiver = new Receiver();
        receiverAddr = payable(address(receiver));
        vm.deal(address(this), 10 ether); // 给测试账户一些ETH
    }

    function testTransfer() public {
        caller.transferTo{value: 1 ether}(receiverAddr);
        assertEq(address(receiver).balance, 1 ether);
    }

    function testSend() public {
        caller.sendTo{value: 1 ether}(receiverAddr);
        assertEq(address(receiver).balance, 1 ether);
    }

    function testCall() public {
        caller.callTo{value: 1 ether}(receiverAddr);
        assertEq(address(receiver).balance, 1 ether);
    }

    function testCallFunction() public {
        bytes memory data = abi.encodeWithSignature("setValue(uint256)", 42);
        caller.callFunction(address(receiver), data);
        assertEq(receiver.value(), 42);
    }

    function testDelegateCall() public {
        bytes memory data = abi.encodeWithSignature("setValue(uint256)", 99);
        caller.delegateTo(address(receiver), data);
        // 值在 Caller 中改变而不是 Receiver
        assertEq(caller.value(), 99);
        assertEq(receiver.value(), 0);
    }
}