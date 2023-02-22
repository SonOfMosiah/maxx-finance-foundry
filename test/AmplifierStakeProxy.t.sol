// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import {IMaxxFinance} from "src/interfaces/IMaxxFinance.sol";
import {MaxxStake, IStake, IERC721} from "src/MaxxStake.sol";
import { LiquidityAmplifier } from "src/LiquidityAmplifier.sol";
import {AmplifierStakeProxy} from "src/AmplifierStakeProxy.sol";

contract AmplifierStakeProxyTest is Test {
    uint256 polygonFork;
    IMaxxFinance public maxx;
    MaxxStake public stake;
    LiquidityAmplifier public amplifier;
    AmplifierStakeProxy public proxy;

    address user = 0x54409dDAdb011eE6e62a5011DeB87CE54f314530;

    string POLYGON_RPC_URL = vm.envString("POLYGON_RPC_URL");

    function setUp() public {
        // Test against Polygon mainnet
        polygonFork = vm.createFork(POLYGON_RPC_URL);
        vm.selectFork(polygonFork);

        // Set up existing contracts
        maxx = IMaxxFinance(address(0x6D9C0b104e5Af90A6d11a13Eb77288e533333301));
        stake = MaxxStake(address(0x3D769818DbD4ed321a2B06342b54513B33333304));
        amplifier = LiquidityAmplifier(address(0x8B3a22019cB68c4cC11Be054124490af33333303));

        // Deploy contracts
        proxy = new AmplifierStakeProxy(address(stake), address(amplifier));
    }

    function test_updateStakePointer() public {
        _updateStakeAddress();
        assertEq(address(amplifier.stake()), address(proxy));
    }

    function test_updateAmplifierPointer() public {
        _updateAmplifierAddress();
        assertEq(address(stake.liquidityAmplifier()), address(proxy));
    }

    function test_amplifierStake(uint256 daysToStake) public {
        _updateStakeAddress();
        _updateAmplifierAddress();

        daysToStake = bound(daysToStake, 7, 3333);
        uint256 idCounter = stake.idCounter();

        vm.prank(user);
        amplifier.claimToStake(15, uint16(daysToStake));

        address stakeOwner = stake.ownerOf(idCounter);
        assertEq(stakeOwner, user);
    }

    function test_amplifierStakeZeroValue(uint256 daysToStake) public {
        _updateStakeAddress();
        _updateAmplifierAddress();

        daysToStake = bound(daysToStake, 7, 3333);

        vm.startPrank(user);
        vm.expectRevert(AmplifierStakeProxy.InvalidAmount.selector);
        amplifier.claimToStake(0, uint16(daysToStake));
        vm.stopPrank();
    }

    function test_amplifierClaimLiquid( uint256 day) public {
        _updateStakeAddress();
        _updateAmplifierAddress();

        day = bound(day, 0, 39);
        _updateStakeAddress();
        _updateAmplifierAddress();

        vm.prank(user);
        amplifier.claim(day);
    }

    function test_claimReferrals() public {
        _updateStakeAddress();
        _updateAmplifierAddress();
        
        vm.prank(user);
        amplifier.claimReferrals();
    }

    function _updateStakeAddress() internal {
        vm.prank(amplifier.owner());
        amplifier.setStakeAddress(address(proxy));
    }

    function _updateAmplifierAddress() internal {
        vm.prank(stake.owner());
        stake.setLiquidityAmplifier(address(proxy));
    }
}