// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "forge-std/script.sol";

import {PrizeClaim} from "src/PrizeClaim.sol";

contract DeployPrizeClaim is Script {

    // address maxx = 0x6D9C0b104e5Af90A6d11a13Eb77288e533333301; // mainnet
    // address stake = 0x3D769818DbD4ed321a2B06342b54513B33333304; // mainnet

    address maxx = 0xE18c300EE16EF18eC17972042045CD05A27e0F9E; // mumbai
    address stake = 0x3375E8D7183ede3Af7086e480d06772888877649; // mumbai

    address _owner = 0x7d9119D1d1D348197EE1F396B3881bC493e78725;

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);
        PrizeClaim prizeClaim = new PrizeClaim(
            _owner,
            maxx,
            stake
        );
        vm.stopBroadcast();
        console.log("Deployed PrizeClaim at", address(prizeClaim));
    }
}

// forge script script/deploy/PrizeClaim.s.sol:DeployPrizeClaim --rpc-url $POLYGON_RPC_URL --broadcast --etherscan-api-key $POLYGONSCAN_API_KEY --verify -vvvv