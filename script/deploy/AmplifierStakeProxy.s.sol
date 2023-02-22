// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "forge-std/script.sol";

import {AmplifierStakeProxy} from "src/AmplifierStakeProxy.sol";

contract DeployAmplifierStakeProxy is Script {

    address stake = 0x3D769818DbD4ed321a2B06342b54513B33333304;
    address amplifier = 0x8B3a22019cB68c4cC11Be054124490af33333303;

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);
        AmplifierStakeProxy proxy = new AmplifierStakeProxy(
            stake,
            amplifier
        );
        vm.stopBroadcast();
        console.log("Deployed AmplifierStakeProxy at", address(proxy));
    }
}

// forge script script/deploy/AmplifierStakeProxy.s.sol:DeployAmplifierStakeProxy --rpc-url $POLYGON_RPC_URL --broadcast --etherscan-api-key $POLYGONSCAN_API_KEY --verify -vvvv