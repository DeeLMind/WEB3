// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {Script, console} from "forge-std/Script.sol";
// import {Types} from "../src/Types.sol";
// import {MsgInspector} from "../src/Msg.sol";
// import {ContextInspector} from "../src/Global.sol";
import {Attacker} from "../src/WrappedEther.sol";

contract TypesScript is Script {
    // Types public types;
    // MsgInspector public msgInspector;
    // ContextInspector public contextInspector;
    Attacker public attacker;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        // types = new Types();
        // msgInspector = new MsgInspector();
        // contextInspector = new ContextInspector();
        attacker = new Attacker();

        vm.stopBroadcast();
    }
}
