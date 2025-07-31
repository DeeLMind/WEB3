// SPDX-License-Identifier: GPL-2.0-or-later
// 声明许可证为 GPL-2.0 或更高版本，符合开源软件许可要求。

pragma solidity =0.7.6;
// 指定 Solidity 编译器版本为 0.7.6，确保代码与该版本的语法和功能兼容。

pragma abicoder v2;
// 启用 ABI 编码器 v2，支持更复杂的数据结构（如结构体和嵌套数组），以便与 Uniswap V3 的接口交互。

import '@uniswap/v3-periphery/contracts/libraries/TransferHelper.sol';
// 导入 Uniswap V3 外围合约库中的 TransferHelper，用于安全地处理 ERC20 代币的转账和授权操作。

import '@uniswap/v3-periphery/contracts/interfaces/ISwapRouter.sol';
// 导入 Uniswap V3 交换路由器的接口，定义了与 Uniswap V3 池交互的函数，如 exactInput 和 exactOutput。

contract multiSwap {
    // 本合约展示了 Uniswap V3 的交换示例，包括：
    // - exactInput：指定输入代币数量，获取最大可能的输出代币。
    // - exactInputSingle：单池精确输入交换。
    // - exactOutput：指定输出代币数量，消耗最小的输入代币。
    // - exactOutputSingle：单池精确输出交换。

    // 为了简化示例，合约通过构造函数传入 SwapRouter 地址，而不是通过继承实现。
    // 更高级的实现可以继承 SwapRouter 来增强安全性。

    // 声明一个不可变的 ISwapRouter 状态变量，用于与 Uniswap V3 的交换路由器交互。
    ISwapRouter public immutable swapRouter;

    // 定义常用代币的地址常量（主网地址），方便在交换中使用。
    // DAI: 一种稳定币，地址固定。
    address public constant DAI = 0x6B175474E89094C44Da98b954EedeAC495271d0F;
    // WETH9: 包装以太坊（Wrapped Ether），以太坊的 ERC20 形式。
    address public constant WETH9 = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;
    // USDC: 另一种稳定币，地址固定。
    address public constant USDC = 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48;

    // 定义池子费用（Pool Fee），这里设置为 0.3%（3000 个基点，Uniswap V3 的常见费用等级）。
    uint24 public constant poolFee = 3000;

    // 构造函数，初始化 SwapRouter 地址。
    // @param _swapRouter Uniswap V3 交换路由器的地址。
    constructor(ISwapRouter _swapRouter) {
        swapRouter = _swapRouter;
    }

    /// @notice swapExactInputMultihop 执行多池精确输入交换，将固定数量的 DAI 交换为尽可能多的 WETH9。
    /// @dev 本函数通过中间池（DAI -> USDC -> WETH9）执行多跳交换。
    ///      调用者必须先授权本合约花费至少 `amountIn` 的 DAI。
    /// @param amountIn 输入的 DAI 数量。
    /// @return amountOut 交换后收到的 WETH9 数量。
    function swapExactInputMultihop(uint256 amountIn) external returns (uint256 amountOut) {
        // 将指定数量的 DAI 从调用者（msg.sender）转移到本合约。
        // 使用 TransferHelper.safeTransferFrom 确保转账安全，防止失败或异常。
        TransferHelper.safeTransferFrom(DAI, msg.sender, address(this), amountIn);

        // 授权 Uniswap V3 路由器从本合约花费指定数量的 DAI。
        // 使用 TransferHelper.safeApprove 确保授权操作安全。
        TransferHelper.safeApprove(DAI, address(swapRouter), amountIn);

        // 定义多池交换的路径（path）。
        // 路径编码格式为 (tokenIn, fee, tokenOut/tokenIn, fee, tokenOut)。
        // 在本例中，交换路径为 DAI -> USDC -> WETH9，中间通过 USDC 作为共享代币。
        // 使用 abi.encodePacked 编码路径，包含代币地址和池子费用。
        ISwapRouter.ExactInputParams memory params =
            ISwapRouter.ExactInputParams({
                path: abi.encodePacked(DAI, poolFee, USDC, poolFee, WETH9),
                recipient: msg.sender, // 交换后的 WETH9 发送到调用者地址。
                deadline: block.timestamp, // 交易截止时间，设置为当前区块时间戳（需立即执行）。
                amountIn: amountIn, // 输入的 DAI 数量。
                amountOutMinimum: 0 // 最小输出代币数量，设置为 0 表示接受任何输出（生产环境中应设置滑点保护）。
            });

        // 调用 Uniswap V3 路由器的 exactInput 函数执行交换。
        // 返回实际收到的 WETH9 数量。
        amountOut = swapRouter.exactInput(params);
    }

    /// @notice swapExactOutputMultihop 执行多池精确输出交换，用最少的 DAI 换取固定数量的 WETH9。
    /// @dev 本函数通过中间池（DAI -> USDC -> WETH9）执行多跳交换，但以输出 WETH9 数量为目标。
    ///      调用者需要授权本合约花费 DAI，因为输入数量可能会有变化，建议授权略高于预期数量。
    /// @param amountOut 期望获得的 WETH9 数量。
    /// @param amountInMaximum 愿意支付的最大 DAI 数量。
    /// @return amountIn 实际消耗的 DAI 数量。
    function swapExactOutputMultihop(uint256 amountOut, uint256 amountInMaximum) external returns (uint256 amountIn) {
        // 将最大允许的 DAI 数量从调用者转移到本合约。
        // 使用 TransferHelper.safeTransferFrom 确保转账安全。
        TransferHelper.safeTransferFrom(DAI, msg.sender, address(this), amountInMaximum);

        // 授权 Uniswap V3 路由器从本合约花费最大允许的 DAI 数量。
        TransferHelper.safeApprove(DAI, address(swapRouter), amountInMaximum);

        // 定义多池交换的路径（path），注意精确输出交换的路径编码顺序与精确输入相反。
        // 路径编码格式为 (tokenOut, fee, tokenIn/tokenOut, fee, tokenIn)。
        // 在本例中，交换路径为 WETH9 -> USDC -> DAI，USDC 是共享代币。
        // 精确输出交换首先执行输出代币的交换（WETH9），因此路径从 WETH9 开始。
        ISwapRouter.ExactOutputParams memory params =
            ISwapRouter.ExactOutputParams({
                path: abi.encodePacked(WETH9, poolFee, USDC, poolFee, DAI),
                recipient: msg.sender, // 交换后的 WETH9 发送到调用者地址。
                deadline: block.timestamp, // 交易截止时间，设置为当前区块时间戳。
                amountOut: amountOut, // 期望获得的 WETH9 数量。
                amountInMaximum: amountInMaximum // 最大允许的 DAI 输入数量。
            });

        // 调用 Uniswap V3 路由器的 exactOutput 函数执行交换。
        // 返回实际消耗的 DAI 数量。
        amountIn = swapRouter.exactOutput(params);

        // 如果实际消耗的 DAI 小于最大允许数量（amountInMaximum），则：
        // 1. 撤销对路由器的 DAI 授权（设置为 0）。
        // 2. 将剩余的 DAI 退还给调用者。
        if (amountIn < amountInMaximum) {
            TransferHelper.safeApprove(DAI, address(swapRouter), 0);
            TransferHelper.safeTransferFrom(DAI, address(this), msg.sender, amountInMaximum - amountIn);
        }
    }
}