// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "@openzeppelin/contracts/utils/cryptography/MerkleProof.sol";
import {PrizeClaim} from "src/PrizeClaim.sol";
import {IMaxxFinance} from "src/interfaces/IMaxxFinance.sol";
import {MaxxStake, IStake, IERC721} from "src/MaxxStake.sol";

import {MerkleConstants} from "test/utils/constants.sol";

struct Leaf {
    address user;
    uint256 amount;
}

/// @title Tests for the PrizeClaim contract
/// @author SonOfMosiah <sonofmosiah.eth>
contract PrizeClaimTest is Test {
    uint256 polygonFork;
    PrizeClaim public prizeClaim;
    IMaxxFinance public maxx;
    MaxxStake public stake;
    MerkleConstants public merkleConstants;

    // *** CONSTANTS ***
    bytes32 public constant MERKLE_ROOT = bytes32(uint256(0xabb5accdede9e311d90c27f03b0de459880504db58165bdc8af27a72f8d46627));
    uint256 public constant MIN_CLAIM_AMOUNT = 25_000 * 1 ether; // 25k MAXX (minimum amount to stake)
    uint256 public constant MIN_STAKE_DURATION = 7;
    uint256 public constant MAX_STAKE_DURATION = 3333;

    string POLYGON_RPC_URL = vm.envString("POLYGON_RPC_URL");

    function setUp() public {
        // Test against Polygon mainnet
        polygonFork = vm.createFork(POLYGON_RPC_URL);
        vm.selectFork(polygonFork);

        // Set up existing contracts
        maxx = IMaxxFinance(address(0x6D9C0b104e5Af90A6d11a13Eb77288e533333301));
        stake = MaxxStake(address(0x3D769818DbD4ed321a2B06342b54513B33333304));

                // Deploy contracts
        merkleConstants = new MerkleConstants();
        prizeClaim = new PrizeClaim(address(this), address(maxx), address(stake));

        // Set external contract addresses
        prizeClaim.setMaxx(address(maxx));
        prizeClaim.setMaxxStake(address(stake));
    }

    function test_addMerkleRoot(bytes32 _merkleRoot) public {
        if (_merkleRoot == bytes32(0)) {
            vm.expectRevert(PrizeClaim.InvalidMerkleRoot.selector);
            prizeClaim.addMerkleRoot(_merkleRoot);
        }
        else {
            prizeClaim.addMerkleRoot(_merkleRoot);
            assertEq(prizeClaim.merkleRoots(0), _merkleRoot);
        }
    }

    function test_addMultipleMerkleRoots(bytes32[] memory _merkleRoots) public {
        uint256 rootCounter;
        for (uint256 i = 0; i < _merkleRoots.length; i++) {
            if (_merkleRoots[i] == bytes32(0)) {
                vm.expectRevert(PrizeClaim.InvalidMerkleRoot.selector);
                prizeClaim.addMerkleRoot(_merkleRoots[i]);
            }
            else {
                prizeClaim.addMerkleRoot(_merkleRoots[i]);
                assertEq(prizeClaim.merkleRoots(rootCounter), _merkleRoots[i]);
                rootCounter++;
            }
        }
    }

    function test_merkleProofs() public {
        Leaf[] memory leaves = merkleConstants.getLeaves();
        bytes32[][] memory proof = merkleConstants.getProofs();
        prizeClaim.addMerkleRoot(MERKLE_ROOT);
        uint256 rootIndex = 0;

        for (uint256 i = 0; i < leaves.length; i++) {
            bytes32 leafNode = keccak256(bytes.concat(keccak256(abi.encode(leaves[i].user, leaves[i].amount))));
            bool success = MerkleProof.verify(proof[i], MERKLE_ROOT, leafNode);
            assertEq(success, true);

            bool success2 = prizeClaim.verifyMerkleLeaf(leaves[i].user, leaves[i].amount, rootIndex, proof[i]);
            assertEq(success2, true);
        }

    }

    function test_claimPrize() public {
        Leaf[] memory leaves = merkleConstants.getLeaves();
        bytes32[][] memory proof = merkleConstants.getProofs();
        prizeClaim.addMerkleRoot(MERKLE_ROOT);
        uint256 rootIndex = 0;

        for (uint256 i = 0; i < leaves.length; i++) {
            deal({
                to: address(prizeClaim),
                token: address(maxx),
                give: leaves[i].amount
            });

            vm.startPrank(leaves[i].user);
            if (leaves[i].amount < MIN_CLAIM_AMOUNT) {
                vm.expectRevert(PrizeClaim.InvalidAmount.selector);
                prizeClaim.claimPrize(leaves[i].amount, rootIndex, proof[i]);
            }
            else {
                prizeClaim.claimPrize(leaves[i].amount, rootIndex, proof[i]);
                uint256 id = stake.idCounter() - 1;
                address stakeOwner = IERC721(address(stake)).ownerOf(id);
                assertEq(stakeOwner, leaves[i].user);
            }
            vm.stopPrank();
        }
    }

    function test_claimPrizeSecondRoot() public {
        Leaf[] memory leaves = merkleConstants.getLeaves();
        bytes32[][] memory proof = merkleConstants.getProofs();
        prizeClaim.addMerkleRoot(bytes32(uint256(1)));
        prizeClaim.addMerkleRoot(MERKLE_ROOT);
        uint256 rootIndex = 1;

        for (uint256 i = 0; i < leaves.length; i++) {
            deal({
                to: address(prizeClaim),
                token: address(maxx),
                give: leaves[i].amount
            });

            vm.startPrank(leaves[i].user);
            if (leaves[i].amount < MIN_CLAIM_AMOUNT) {
                vm.expectRevert(PrizeClaim.InvalidAmount.selector);
                prizeClaim.claimPrize(leaves[i].amount, rootIndex, proof[i]);
            }
            else {
                prizeClaim.claimPrize(leaves[i].amount, rootIndex, proof[i]);
                uint256 id = stake.idCounter() - 1;
                address stakeOwner = IERC721(address(stake)).ownerOf(id);
                assertEq(stakeOwner, leaves[i].user);
            }
            vm.stopPrank();
        }
    }

    function test_claimPrizeSecondAttempt() public {
        Leaf[] memory leaves = merkleConstants.getLeaves();
        bytes32[][] memory proof = merkleConstants.getProofs();
        prizeClaim.addMerkleRoot(MERKLE_ROOT);
        uint256 rootIndex = 0;

        deal({
                to: address(prizeClaim),
                token: address(maxx),
                give: leaves[0].amount
            });

        vm.startPrank(leaves[0].user);
        prizeClaim.claimPrize(leaves[0].amount, rootIndex, proof[0]);
        uint256 id = stake.idCounter() - 1;
        address stakeOwner = IERC721(address(stake)).ownerOf(id);
        assertEq(stakeOwner, leaves[0].user);
        bool hasClaimed = prizeClaim.hasClaimed(leaves[0].user, rootIndex);
        assertEq(hasClaimed, true); 

        // attempting to claim again should fail
        vm.expectRevert(PrizeClaim.AlreadyClaimed.selector);
        prizeClaim.claimPrize(leaves[0].amount, rootIndex, proof[0]);
        vm.stopPrank();
    }

    function test_claimPrizeInvalidUser(address invalidUser) public {
        Leaf[] memory leaves = merkleConstants.getLeaves();
        bytes32[][] memory proof = merkleConstants.getProofs();
        prizeClaim.addMerkleRoot(MERKLE_ROOT);
        uint256 rootIndex = 0;

        vm.assume(invalidUser != leaves[0].user);

        vm.startPrank(invalidUser);
        vm.expectRevert(PrizeClaim.InvalidProof.selector);
        prizeClaim.claimPrize(leaves[0].amount, rootIndex, proof[0]);
        vm.stopPrank();
    }

    function test_claimPrizeInvalidAmount(uint256 invalidAmount) public {
        Leaf[] memory leaves = merkleConstants.getLeaves();
        bytes32[][] memory proof = merkleConstants.getProofs();
        prizeClaim.addMerkleRoot(MERKLE_ROOT);
        uint256 rootIndex = 0;

        vm.assume(invalidAmount != leaves[0].amount);

        vm.startPrank(leaves[0].user);
        vm.expectRevert(PrizeClaim.InvalidProof.selector);
        prizeClaim.claimPrize(invalidAmount, rootIndex, proof[0]);
        vm.stopPrank();
    }

    function test_claimPrizeInvalidProof(uint256 _amount) public {
        Leaf[] memory leaves = merkleConstants.getLeaves();
        bytes32[] memory invalidProof = new bytes32[](1);
        prizeClaim.addMerkleRoot(MERKLE_ROOT);
        uint256 rootIndex = 0;

        vm.startPrank(leaves[0].user);
        vm.expectRevert(PrizeClaim.InvalidProof.selector);
        prizeClaim.claimPrize(_amount, rootIndex, invalidProof);
        vm.stopPrank();
    }

    function test_adminCreateStake(address _user, uint256 _amount, uint256 _duration) public {
        // Can't transfer to address(0)
        vm.assume(_user != address(0));
        // Stake amount must be between MIN_CLAIM_AMOUNT and MAX_CLAIM_AMOUNT
        _amount = bound(_amount, MIN_CLAIM_AMOUNT, type(uint256).max);
        // Stake duration must be between MIN_STAKE_DURATION (7 days) and MAX_STAKE_DURATION (3333 days)
        _duration = bound(_duration, MIN_STAKE_DURATION, MAX_STAKE_DURATION);
        deal({
                to: address(prizeClaim),
                token: address(maxx),
                give: _amount
            });
        prizeClaim.adminCreateStake(_user, _amount, _duration);
        uint256 id = stake.idCounter() - 1;
        address stakeOwner = IERC721(address(stake)).ownerOf(id);
        assertEq(stakeOwner, _user);

    }

    function test_invalidAdminStakeAmountLow(address _user, uint256 _amount, uint256 _duration) public {
        vm.assume(_user != address(0));
        _amount = bound(_amount, 0, MIN_CLAIM_AMOUNT - 1);
        _duration = bound(_duration, MIN_STAKE_DURATION, MAX_STAKE_DURATION);
        deal({
                to: address(prizeClaim),
                token: address(maxx),
                give: _amount
            });
        vm.expectRevert(IStake.InvalidAmount.selector);
        prizeClaim.adminCreateStake(_user, _amount, _duration);
    }
}