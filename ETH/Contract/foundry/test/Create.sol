// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleContract {
    uint256 public value;

    constructor(uint256 _value) {
        value = _value;
    }

    function getValue() external view returns (uint256) {
        return value;
    }
}

contract Factory {
    // 记录通过 CREATE 部署的合约地址
    address[] public createdContracts;
    // 记录通过 CREATE2 部署的合约地址
    mapping(bytes32 => address) public created2Contracts;

    // 使用 CREATE 部署 SimpleContract
    function deployWithCreate(uint256 _value) external returns (address) {
        SimpleContract newContract = new SimpleContract(_value);
        createdContracts.push(address(newContract));
        return address(newContract);
    }

    // 使用 CREATE2 部署 SimpleContract
    function deployWithCreate2(uint256 _value, bytes32 _salt) external returns (address) {
        // 使用 CREATE2 部署
        SimpleContract newContract = new SimpleContract{salt: _salt}(_value);
        created2Contracts[_salt] = address(newContract);
        return address(newContract);
    }

    // 预计算 CREATE2 部署的地址
    function predictCreate2Address(uint256 _value, bytes32 _salt) public view returns (address) {
        // 构造初始化代码
        bytes memory bytecode = abi.encodePacked(
            type(SimpleContract).creationCode,
            abi.encode(_value)
        );
        // 计算 CREATE2 地址
        return address(uint160(uint(keccak256(abi.encodePacked(
            bytes1(0xff),
            address(this),
            _salt,
            keccak256(bytecode)
        )))));
    }

    // 获取通过 CREATE 部署的合约列表
    function getCreatedContracts() external view returns (address[] memory) {
        return createdContracts;
    }
}

import "forge-std/Test.sol";

contract FactoryTest is Test {
    Factory factory;
    address deployer;

    function setUp() public {
        deployer = address(this);
        factory = new Factory();
    }

    // 测试 CREATE 部署
    function testDeployWithCreate() public {
        uint256 value = 42;
        address newContract = factory.deployWithCreate(value);
        
        // 验证合约地址非零
        assertTrue(newContract != address(0), "Contract address should not be zero");
        
        // 验证合约功能
        SimpleContract simple = SimpleContract(newContract);
        assertEq(simple.getValue(), value, "Contract value should match input");
        
        // 验证存储
        address[] memory contracts = factory.getCreatedContracts();
        assertEq(contracts.length, 1, "Should have one contract");
        assertEq(contracts[0], newContract, "Stored address should match");
    }

    // 测试 CREATE2 部署和地址预测
    function testDeployWithCreate2() public {
        uint256 value = 100;
        bytes32 salt = bytes32(uint256(1234));
        
        // 预计算地址
        address predictedAddress = factory.predictCreate2Address(value, salt);
        assertTrue(predictedAddress != address(0), "Predicted address should not be zero");
        
        // 部署合约
        address actualAddress = factory.deployWithCreate2(value, salt);
        
        // 验证预测地址与实际地址一致
        assertEq(predictedAddress, actualAddress, "Predicted address should match actual address");
        
        // 验证合约功能
        SimpleContract simple = SimpleContract(actualAddress);
        assertEq(simple.getValue(), value, "Contract value should match input");
        
        // 验证存储
        assertEq(factory.created2Contracts(salt), actualAddress, "Stored address should match");
    }

    // 测试 CREATE2 重复 salt 失败
    function testFailDeployWithCreate2SameSalt() public {
        uint256 value = 100;
        bytes32 salt = bytes32(uint256(1234));
        
        // 第一次部署
        factory.deployWithCreate2(value, salt);
        
        // 第二次部署相同 salt 应失败
        vm.expectRevert();
        factory.deployWithCreate2(value, salt);
    }

    // 测试 CREATE2 不同 salt 不同地址
    function testDeployWithCreate2DifferentSalts() public {
        uint256 value = 100;
        bytes32 salt1 = bytes32(uint256(1234));
        bytes32 salt2 = bytes32(uint256(5678));
        
        address addr1 = factory.deployWithCreate2(value, salt1);
        address addr2 = factory.deployWithCreate2(value, salt2);
        
        assertTrue(addr1 != addr2, "Different salts should produce different addresses");
    }
}