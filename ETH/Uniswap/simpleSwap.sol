// SPDX-License-Identifier: GPL-2.0-or-later
// 指定代码采用的许可证类型。
// GPL-2.0-or-later 表示代码在 GNU 通用公共许可证第 2 版或更高版本下使用，允许自由分发和修改。

pragma solidity =0.7.6;
// 指定 Solidity 编译器的精确版本（0.7.6），以确保兼容性并避免新版本编译器可能带来的问题。

pragma abicoder v2;
// 启用 ABI 编码器 v2，支持更复杂的数据类型（如结构体）作为函数参数和返回值。
// 这对于与 Uniswap V3 接口交互是必要的，因为 Uniswap V3 使用结构体来传递参数。

import '@uniswap/v3-periphery/contracts/interfaces/ISwapRouter.sol';
// 从 Uniswap V3 外围合约中导入 SwapRouter 接口。
// ISwapRouter 定义了与 Uniswap V3 交换路由器交互的函数（如 exactInputSingle），用于执行代币交换。

import '@uniswap/v3-periphery/contracts/libraries/TransferHelper.sol';
// 导入 Uniswap V3 外围合约中的 TransferHelper 库。
// TransferHelper 提供安全的代币转账和授权函数（如 safeTransferFrom 和 safeApprove），以处理 ERC-20 代币操作。

contract SimpleSwap {
    // 定义一个名为 SimpleSwap 的智能合约，用于在 Uniswap V3 上执行 WETH 到 DAI 的代币交换。

    ISwapRouter public immutable swapRouter;
    // 声明一个公共的、不可变的 ISwapRouter 类型变量 swapRouter，用于存储 Uniswap V3 交换路由器的地址。
    // immutable 表示该变量在构造函数中设置后不可更改，节省 gas 费用。

    address public constant DAI = 0x6B175474E89094C44Da98b954EedeAC495271d0F;
    // 声明 DAI 代币的地址为常量，指向主网上的 DAI 合约地址。
    // constant 表示该值在编译时确定且不可更改。

    address public constant WETH9 = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;
    // 声明 WETH9（包装以太币）代币的地址为常量，指向主网上的 WETH 合约地址。
    // WETH 是 ERC-20 格式的以太币，方便在 Uniswap 上交易。

    uint24 public constant feeTier = 3000;
    // 声明 Uniswap V3 交易池的费用层级为 3000（即 0.3% 的交易费用）。
    // Uniswap V3 支持多种费用层级（如 0.05%、0.3%、1%），这里选择 0.3% 的池子。

    constructor(ISwapRouter _swapRouter) {
        // 构造函数，在部署合约时调用，用于初始化 swapRouter 地址。
        // 参数 _swapRouter 是 Uniswap V3 交换路由器的地址。
        swapRouter = _swapRouter;
        // 将传入的路由器地址赋值给不可变的 swapRouter 变量。
    }

    function swapWETHForDAI(uint256 amountIn) external returns (uint256 amountOut) {
        // 定义一个公共函数 swapWETHForDAI，允许用户将指定数量的 WETH 兑换为 DAI。
        // 参数 amountIn：用户希望输入的 WETH 数量。
        // 返回值 amountOut：通过交换获得的 DAI 数量。
        // external 修饰符表示该函数只能从合约外部调用。

        // Transfer the specified amount of WETH9 to this contract.
        TransferHelper.safeTransferFrom(WETH9, msg.sender, address(this), amountIn);
        // 使用 TransferHelper 库的 safeTransferFrom 函数，从调用者（msg.sender）向本合约（address(this)）转移指定数量的 WETH。
        // WETH9 是代币地址，amountIn 是转账数量。
        // safeTransferFrom 会检查转账是否成功，若失败则回滚交易。

        // Approve the router to spend WETH9.
        TransferHelper.safeApprove(WETH9, address(swapRouter), amountIn);
        // 使用 TransferHelper 库的 safeApprove 函数，授权 Uniswap V3 路由器（swapRouter）从本合约中花费指定数量的 WETH。
        // 这是 ERC-20 代币标准的要求，允许路由器代表合约执行代币转移。

        // Note: To use this example, you should explicitly set slippage limits, omitting for simplicity
        uint256 minOut = /* Calculate min output */ 0;
        // 定义最小输出量 minOut，表示用户愿意接受的最小 DAI 数量（防止滑点过大）。
        // 这里简化为 0，实际使用中应根据市场价格计算合理的滑点保护值。

        uint160 priceLimit = /* Calculate price limit */ 0;
        // 定义价格限制 sqrtPriceLimitX96，表示交换的价格限制（基于 Uniswap V3 的 sqrtPriceX96 格式）。
        // 这里简化为 0，实际使用中应设置合理的价格限制以防止不利执行。

        // Create the params that will be used to execute the swap
        ISwapRouter.ExactInputSingleParams memory params =
            ISwapRouter.ExactInputSingleParams({
                tokenIn: WETH9,
                // 输入代币为 WETH9。
                tokenOut: DAI,
                // 输出代币为 DAI。
                fee: feeTier,
                // 费用层级为 3000（0.3%）。
                recipient: msg.sender,
                // 接收交换后 DAI 的地址为函数调用者（msg.sender）。
                deadline: block.timestamp,
                // 交易截止时间为当前区块时间戳，防止交易在未来被恶意执行。
                amountIn: amountIn,
                // 输入的 WETH 数量。
                amountOutMinimum: minOut,
                // 最小输出 DAI 数量，用于滑点保护。
                sqrtPriceLimitX96: priceLimit
                // 价格限制，用于限制交易执行的价格范围。
            });
        // 创建一个 ExactInputSingleParams 结构体，包含执行单路径交换所需的所有参数。
        // memory 关键字表示 params 是存储在内存中的临时变量。

        // The call to `exactInputSingle` executes the swap.
        amountOut = swapRouter.exactInputSingle(params);
        // 调用 Uniswap V3 路由器的 exactInputSingle 函数，执行精确输入的单路径交换。
        // 函数将 WETH 兑换为 DAI，并返回实际获得的 DAI 数量（amountOut）。
        // params 包含所有交换参数，路由器会处理池选择、价格计算和代币转移。
    }
}