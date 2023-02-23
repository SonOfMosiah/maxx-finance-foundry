// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {SafeERC20, IERC20} from "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {ReentrancyGuard} from "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import {MerkleProof} from "@openzeppelin/contracts/utils/cryptography/MerkleProof.sol";

import {IMaxxStake} from "./interfaces/IMaxxStake.sol";

/// @title Maxx Finance Prize Claim
/// @author SonOfMosiah <sonofmosiah.eth>
contract PrizeClaim is Ownable, ReentrancyGuard {
    using SafeERC20 for IERC20;

    /// @notice The provided proof is not included in the merkle root
    error InvalidProof();
    /// @notice The claim amount is less than the minimum
    error InvalidAmount();
    /// @notice The user has already claimed this prize
    error AlreadyClaimed();
    /// @notice The duration must be between 7 and 3333
    error InvalidDuration();
    /// @notice The MAXX token transfer failed
    error MaxxWithdrawFailed();
    /// @notice The merkle root cannot be zero
    error InvalidMerkleRoot();
    /// @notice The maxx address cannot be zero
    error InvalidAddress();

    /// @notice Emitted when a merkle root is added
    /// @param merkleRootIndex The index of the merkle root
    /// @param merkleRoot The merkle root
    event MerkleRootAdded(uint256 merkleRootIndex, bytes32 merkleRoot);

    /// @notice Emitted when the MAXX token is set
    /// @param maxxAddress The address of the MAXX token
    event MaxxSet(address maxxAddress);

    /// @notice Emitted when the MAXX staking contract is set
    /// @param maxxStakeAddress The address of the MAXX staking contract
    event MaxxStakeSet(address maxxStakeAddress);

    /// @notice Emitted when a user claims a prize
    /// @param merkleRootIndex The index of the merkle root
    /// @param user The user address
    /// @param amount The amount of MAXX staked
    /// @param duration The duration of the stake
    /// @param stakeName The name of the stake
    event PrizeClaimed(uint256 merkleRootIndex, address user, uint256 amount, uint256 duration, string stakeName);

    /// @notice Emitted when an admin creates a stake for a user
    /// @param user The user address
    /// @param amount The amount of MAXX staked
    /// @param duration The duration of the stake
    event AdminCreatedStake(address user, uint256 amount, uint256 duration);

    /// @notice Array of Merkle roots for the prize claim lists
    bytes32[] public merkleRoots;

    /// @notice Min MAXX amount per claim
    uint256 public constant MIN_CLAIM_AMOUNT = 25_000 * 1 ether; // 25k MAXX (minimum amount to stake)

    /// @notice MAXX token contract
    IERC20 public maxx;

    /// @notice MAXX staking contract
    IMaxxStake public maxxStake;

    /// @notice True if user has already claimed MAXX
    mapping(address user => mapping(uint256 rootIndex => bool claim)) public hasClaimed;

    /// @notice The total amount of MAXX claimed
    uint256 public claimedAmount;

    constructor(address _owner, address _maxx, address _maxxStake) {
        _transferOwnership(_owner);
        maxx = IERC20(_maxx);
        maxxStake = IMaxxStake(_maxxStake);
    }

    /// @notice Function to claim MAXX prize
    /// @param _amount The MAXX prize amount for the sender
    /// @param _duration The duration of the stake
    /// @param _rootIndex The index of the merkle root
    /// @param stakeName The name of the stake
    /// @param _proof The merkle proof of the prize
    function claimPrize(
        uint256 _amount,
        uint256 _duration,
        uint256 _rootIndex,
        string memory stakeName,
        bytes32[] memory _proof
    ) external nonReentrant {
        if (
            !_verifyMerkleLeaf(_generateMerkleLeaf(msg.sender, _amount, _duration, stakeName), _rootIndex,  _proof)
        ) {
            revert InvalidProof();
        }

        if (_amount < MIN_CLAIM_AMOUNT) {
            revert InvalidAmount();
        }

        if (hasClaimed[msg.sender][_rootIndex]) {
            revert AlreadyClaimed();
        }

        hasClaimed[msg.sender][_rootIndex] = true;

        claimedAmount += _amount;

        maxxStake.stake(_duration, _amount);
        // Change the name
        uint256 stakeId = maxxStake.idCounter() - 1;
        maxxStake.changeStakeName(stakeId, stakeName);
        maxxStake.transfer(msg.sender, stakeId);
        emit PrizeClaimed(_rootIndex, msg.sender, _amount, _duration, stakeName);
    }

    /// @notice Function to create a stake for `user` `_amount` MAXX for `_duration` seconds
    /// @dev This function is only callable by the owner
    /// @param _user The user to create the stake for
    /// @param _amount The amount of MAXX to stake
    /// @param _duration The duration of the stake
    function adminCreateStake(address _user, uint256 _amount, uint256 _duration) external onlyOwner {
        if (_amount < MIN_CLAIM_AMOUNT) {
            revert InvalidAmount();
        }
        if (_duration < 7 || _duration > 3333) {
            revert InvalidDuration();
        }
        maxxStake.stake(_duration, _amount);
        maxxStake.transfer(_user, maxxStake.idCounter() - 1);
        emit AdminCreatedStake(_user, _amount, _duration);
    }

    /// @notice Function to add a merkle root
    /// @dev Emits a MerkleRootAdded event
    /// @param _merkleRoot The merkle root to add
    function addMerkleRoot(bytes32 _merkleRoot) external onlyOwner {
        if (_merkleRoot == bytes32(0)) {
            revert InvalidMerkleRoot();
        }
        merkleRoots.push(_merkleRoot);
        emit MerkleRootAdded(merkleRoots.length - 1, _merkleRoot);
    }

    /// @notice Set the Maxx Finance Staking contract
    /// @dev Emits a MaxxStakeSet event
    /// @param _maxxStake The Maxx Finance Staking contract
    function setMaxxStake(address _maxxStake) external onlyOwner {
        if (_maxxStake == address(0)) {
            revert InvalidAddress();
        }
        maxxStake = IMaxxStake(_maxxStake);
        maxx.approve(_maxxStake, type(uint256).max);
        emit MaxxStakeSet(_maxxStake);
    }

    /// @notice Function to set the MAXX token address
    /// @dev Emits a MaxxSet event
    /// @param _maxx The maxx token contract address
    function setMaxx(address _maxx) external onlyOwner {
        if (_maxx == address(0)) {
            revert InvalidAddress();
        }
        maxx = IERC20(_maxx);
        emit MaxxSet(_maxx);
    }

    /// @notice Withdraw `_amount` MAXX from the contract
    /// @dev Only the owner can withdraw MAXX
    /// @param _amount The amount of MAXX to withdraw
    function withdrawMaxx(uint256 _amount) external onlyOwner {
        if (!maxx.transfer(msg.sender, _amount)) {
            revert MaxxWithdrawFailed();
        }
    }

    /// @notice Returns the merkle root at `_rootIndex`
    /// @param _rootIndex The index of the merkle root
    /// @return The merkle root at `_rootIndex`
    function getMerkleRoot(uint256 _rootIndex) external view returns (bytes32) {
        return merkleRoots[_rootIndex];
    }

    /// @notice Function to verify a merkle leaf
    /// @param _account The account presumed to be in the merkle tree
    /// @param _amount The amount of MAXX available for the account to claim
    /// @param _duration The duration of the stake
    /// @param _rootIndex The index of the merkle root
    /// @param stakeName The name of the stake
    /// @param _proof The merkle proof of the account
    /// @return Whether the account is in the merkle tree
    function verifyMerkleLeaf(
        address _account,
        uint256 _amount,
        uint256 _duration,
        uint256 _rootIndex,
        string memory stakeName,
        bytes32[] memory _proof
    ) external view returns (bool) {
        return
            _verifyMerkleLeaf(_generateMerkleLeaf(_account, _amount, _duration, stakeName), _rootIndex, _proof);
    }

    function _verifyMerkleLeaf(bytes32 _leafNode, uint256 _rootIndex, bytes32[] memory _proof)
        internal
        view 
        returns (bool)
    {
        return MerkleProof.verify(_proof, merkleRoots[_rootIndex], _leafNode);
    }

    function _generateMerkleLeaf(address _account, uint256 _amount, uint256 _duration, string memory stakeName)
        internal
        pure
        returns (bytes32)
    {
        return keccak256(bytes.concat(keccak256(abi.encode(_account, _amount, _duration, stakeName))));
    }
}
