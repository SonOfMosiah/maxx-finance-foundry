// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "forge-std/script.sol";

import {MaxxStake} from "src/MaxxStake.sol";

contract DeployMaxxStake is Script {

    // address maxx = 0x6D9C0b104e5Af90A6d11a13Eb77288e533333301; // mainnet

    address maxx = 0xE18c300EE16EF18eC17972042045CD05A27e0F9E; // mumbai
    address maxxVault = 0xDb0EAe4c4DDb75413d85B62B8391bFde75702B5a; // mumbai

    address _owner = 0x7d9119D1d1D348197EE1F396B3881bC493e78725;

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);
        MaxxStake maxxStake = new MaxxStake();
        maxxStake.init(maxxVault, maxx, block.timestamp);
        vm.stopBroadcast();
        console.log("Deployed PrizeClaim at", address(maxxStake));
    }
}

// forge script script/deploy/MaxxStake.s.sol:DeployMaxxStake --rpc-url $POLYGON_RPC_URL --broadcast --etherscan-api-key $POLYGONSCAN_API_KEY --verify -vvvv
// forge script script/deploy/MaxxStake.s.sol:DeployMaxxStake --rpc-url $MUMBAI_RPC_URL --broadcast --etherscan-api-key $POLYGONSCAN_API_KEY --verify -vvvv