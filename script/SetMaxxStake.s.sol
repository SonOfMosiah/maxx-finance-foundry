// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "forge-std/script.sol";

import {PrizeClaim} from "src/PrizeClaim.sol";

contract SetMaxxStake is Script {

    // address stake = 0x3D769818DbD4ed321a2B06342b54513B33333304; // mainnet

    address stake = 0x186Ff4623BCe91f5d37BB5Ee17bFd3096276C3dE; // mumbai
    address prizeClaimAddress = 0x28c2767CD91cad25Ac6486C51614F47dd770644D;

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);
        PrizeClaim prizeClaim = PrizeClaim(prizeClaimAddress
        );
        prizeClaim.setMaxxStake(stake);
        vm.stopBroadcast();
    }
}

// forge script script/SetMaxxStake.s.sol:SetMaxxStake --rpc-url $POLYGON_RPC_URL --broadcast -vvvv
// forge script script/SetMaxxStake.s.sol:SetMaxxStake --rpc-url $MUMBAI_RPC_URL --broadcast -vvvv