// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

/**
 * @title IGauge
 * @notice Interfaz del contrato Gauge para staking de LP tokens y distribución de recompensas.
 */
interface IGauge {
    function stakingToken() external view returns (address);
    function rewardToken() external view returns (address);
    function feesVotingReward() external view returns (address);
    function voter() external view returns (address);
    function team() external view returns (address);
    function isPool() external view returns (bool);

    function periodFinish() external view returns (uint256);
    function rewardRate() external view returns (uint256);
    function rewardPerTokenStored() external view returns (uint256);
    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function userRewardPerTokenPaid(address account) external view returns (uint256);
    function rewards(address account) external view returns (uint256);

    function deposit(uint256 amount) external;
    function deposit(uint256 amount, address recipient) external;
    function withdraw(uint256 amount) external;
    function earned(address account) external view returns (uint256);
    function getReward(address account) external;

    function notifyRewardAmount(uint256 amount) external;
    function notifyRewardWithoutClaim(uint256 amount) external;

    function lastTimeRewardApplicable() external view returns (uint256);
    function rewardPerToken() external view returns (uint256);
    function left() external view returns (uint256);
    function lastUpdateTime() external view returns (uint256);
}
