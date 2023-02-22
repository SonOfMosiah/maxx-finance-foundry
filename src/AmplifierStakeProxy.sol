// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {IStake} from "src/interfaces/IStake.sol";
import {IMaxxFinance} from "src/interfaces/IMaxxFinance.sol";

/// @title AmplifierStakeProxy
/// @author SonOfMosiah <sonofmosiah.eth>
/// @notice This contract is used to allow the Amplifier contract to stake MAXX
/// @dev This contract is used to allow the Amplifier contract to stake MAXX and disallows stakes with amount 0
contract AmplifierStakeProxy {
    /// @notice Only the amplifier contract can call this function
    error OnlyAmplifier();
    /// @notice The amount to stake must be greater than 0
    error InvalidAmount();
    /// @notice The transfer of MAXX to the proxy failed
    error TransferFailed();
    /// @notice The approval of MAXX to the stake contract failed
    error ApprovalFailed();

    address public constant maxx = 0x6D9C0b104e5Af90A6d11a13Eb77288e533333301;
    address public immutable stake;
    address public immutable amplifier;
    uint256 public immutable launchDate;

    modifier onlyAmplifier() {
        if (msg.sender != amplifier) {
            revert OnlyAmplifier();
        }
        _;
    }

    constructor(address _stake, address _amplifier) {
        stake = _stake;
        amplifier = _amplifier;
        launchDate = IStake(_stake).launchDate();
    }

    /// @notice Intermediate function to send an amplifier stake to the stake contract
    /// @dev This function will check for stakes with amount 0 and revert
    /// @param owner The owner of the stake
    /// @param numDays The number of days to stake
    /// @param amount The amount of MAXX to stake
    /// @return stakeId The ID of the stake
    /// @return shares The number of shares the stake is worth
    function amplifierStake(address owner, uint256 numDays, uint256 amount) external onlyAmplifier returns (uint256 stakeId, uint256 shares) {
        if (amount == 0) {
            revert InvalidAmount();
        }
        if (!IMaxxFinance(maxx).transferFrom(msg.sender, address(this), amount)) {
            revert TransferFailed();
        }
        if (!IMaxxFinance(maxx).approve(address(stake), amount)) {
            revert ApprovalFailed();
        }

        (stakeId, shares) = IStake(stake).amplifierStake(owner, numDays, amount);

        return (stakeId, shares);
    }
}