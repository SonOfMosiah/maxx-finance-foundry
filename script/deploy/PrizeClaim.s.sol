// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "forge-std/script.sol";

import {PrizeClaim} from "src/PrizeClaim.sol";

contract DeployPrizeClaim is Script {

    address maxx = 0x6D9C0b104e5Af90A6d11a13Eb77288e533333301;
    address stake = 0x3D769818DbD4ed321a2B06342b54513B33333304;

    address _owner = 0x54409dDAdb011eE6e62a5011DeB87CE54f314530; // TODO: replace with the owner address

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