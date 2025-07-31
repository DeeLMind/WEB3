// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Proxy {
    // 逻辑合约地址
    address public implementation;

    // 管理员地址
    address public admin;

    // 构造函数，初始化管理员和逻辑合约地址
    constructor(address _implementation) {
        admin = msg.sender;
        implementation = _implementation;
    }

    // 限制只有管理员可以调用
    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can call this function");
        _;
    }

    // 升级逻辑合约地址
    function upgrade(address _newImplementation) external onlyAdmin {
        implementation = _newImplementation;
    }

    // 回退函数，将调用转发到逻辑合约
    fallback() external payable {
        address impl = implementation;
        require(impl != address(0), "Implementation not set");

        // 使用delegatecall转发调用
        (bool success, bytes memory data) = impl.delegatecall(msg.data);
    }

    // 接收以太坊转账
    receive() external payable {}
}

contract LogicV1 {
    // 存储变量
    uint256 public value;

    // 设置值的函数
    function setValue(uint256 _value) external {
        value = _value;
    }

    // 获取值的函数
    function getValue() external view returns (uint256) {
        return value;
    }

    // 版本标识
    function version() external pure returns (string memory) {
        return "V1";
    }
}

contract LogicV2 {
    // 存储变量，必须与V1保持一致
    uint256 public value;

    // 设置值的函数，添加新功能
    function setValue(uint256 _value) external {
        value = _value * 2; // 新逻辑：值翻倍
    }

    // 获取值的函数
    function getValue() external view returns (uint256) {
        return value;
    }

    // 版本标识
    function version() external pure returns (string memory) {
        return "V2";
    }

    // 新增功能
    function increment() external {
        value += 1;
    }
}