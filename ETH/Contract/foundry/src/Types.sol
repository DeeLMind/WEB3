// SPDX-License-Identifier: UNLICENSED
// https://spdx.org/licenses/

pragma solidity ^0.8.13;

// | 写法                                | 意义                         |
// | --------------------------------- | -------------------------- |
// | `pragma solidity ^0.8.13;`        | 允许 `>=0.8.13 <0.9.0`（推荐）   |
// | `pragma solidity >=0.8.0;`        | 允许所有 `0.8.x`，**不安全，可能不兼容** |
// | `pragma solidity 0.8.13;`         | **只允许** 0.8.13，过于严格        |
// | `pragma solidity >=0.8.4 <0.9.0;` | 精确控制版本范围，适合团队开发            |

contract Types {
    // ---------- 整数类型 ----------
    int256 public intVar = -123;           // 有符号整数（-2^255 ~ 2^255-1）
    uint256 public uintVar = 123;          // 无符号整数（0 ~ 2^256-1）

    int8 public int8Var = -10;             // int8: -128 ~ 127
    uint8 public uint8Var = 250;           // uint8: 0 ~ 255

    // ---------- 布尔类型 ----------
    bool public boolVar = true;

    // ---------- 地址类型 ----------
    address public addr = 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2;
    address payable public payableAddr = payable(addr); // 可接收 ETH 的地址

    // ---------- 固定长度字节数组 ----------
    bytes1 public byte1 = 0x01;
    bytes32 public byte32 = "hello";        // 固定长度字节序列（最大 32 字节）

    // ---------- 动态字节数组 / 字符串 ----------
    bytes public dynamicBytes = "abc";      // 动态字节序列
    string public str = "Hello World";      // 字符串（UTF-8）

    // ---------- 枚举 ----------
    enum Status { Pending, Shipped, Delivered }
    Status public status = Status.Pending;

    // ---------- 结构体 ----------
    struct Person {
        string name;
        uint256 age;
    }
    Person public person = Person("Alice", 30);

    // ---------- 数组 ----------
    uint[] public dynamicArray = [1, 2, 3];          // 动态数组
    uint[3] public fixedArray = [4, 5, 6];           // 固定数组

    // ---------- 映射 ----------
    mapping(address => uint256) public balances;

    // ---------- 常量和不可变变量 ----------
    uint256 public constant CONST_VAL = 100;         // 编译时常量
    uint256 public immutable IMMUTABLE_VAL;          // 部署时设置，不可变

    constructor() {
        IMMUTABLE_VAL = 999;
    }

    // ---------- 函数内部变量示例 ----------
    function example() public pure returns (uint256) {
        uint256 localVar = 42; // 局部变量
        return localVar;
    }
}