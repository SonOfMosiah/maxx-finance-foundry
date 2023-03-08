pragma solidity ^0.8.13;
import "forge-std/Script.sol";

import {PrizeClaim} from "src/PrizeClaim.sol";

contract InitCodeHash is Script {
    function run() public returns (bytes32) {
        // get bytecode for DuoswapV2Pair
        bytes memory bytecode = type(PrizeClaim).creationCode;
        bytes32 hash = keccak256(bytes(bytecode));
        
        console.logBytes32(hash);
        return hash;
    }
}

// forge script script/InitCodeHash.s.sol:InitCodeHash
