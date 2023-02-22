// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

/// @title The interface for the Maxx Finance staking contract
interface IMaxxStake is IERC721 {

    function idCounter() external view returns (uint256);

    function stake(
        uint256 numDays,
        uint256 amount
    ) external;

    function transfer(
        address to,
        uint256 stakeId
    ) external;

    function changeStakeName(uint256 stakeId, string memory stakeName) external;
}
