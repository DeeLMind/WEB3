// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import "forge-std/Test.sol";

// calldata = selector (4 bytes) + encoded arguments = msg.data

contract CalldataTest is Test {
    function testEncodeCalldataVariants() public {
        address to = 0xB409cfD12E00606cb4F48aD4281683915da77b6f;
        uint256 amount = 1000;

        /// ---- 1️⃣ selector ----
        bytes4 selector = bytes4(keccak256("transfer(address,uint256)"));
        console.log("Function selector:");
        console.logBytes4(selector); //0xa9059cbb

        /// ---- 2️⃣ encodeWithSelector (标准 calldata 构造) ----
        bytes memory calldata1 = abi.encodeWithSelector(selector, to, amount);
        console.log("abi.encodeWithSelector:");
        console.logBytes(calldata1);
        // a9059cbb
        // 000000000000000000000000b409cfd12e00606cb4f48ad4281683915da77b6f
        // 00000000000000000000000000000000000000000000000000000000000003e8

        /// ---- 3️⃣ encodeWithSignature (自动生成 selector) ----
        bytes memory calldata2 = abi.encodeWithSignature("transfer(address,uint256)", to, amount);
        console.log("abi.encodeWithSignature:");
        console.logBytes(calldata2);

        /// ---- 4️⃣ encode (标准 ABI 对齐编码) ----
        bytes memory encoded = abi.encode(to, amount);
        console.log("abi.encode:");
        console.logBytes(encoded);

        /// ✅ decode 检验 encode
        (address decodedTo, uint256 decodedAmount) = abi.decode(encoded, (address, uint256));
        console.log("Decoded address:");
        console.logAddress(decodedTo);
        console.log("Decoded amount:");
        console.logUint(decodedAmount);

        /// ---- 5️⃣ encodePacked (紧凑拼接) ----
        bytes memory packed = abi.encodePacked(to, amount);
        console.log("abi.encodePacked:");
        console.logBytes(packed);
    }
}