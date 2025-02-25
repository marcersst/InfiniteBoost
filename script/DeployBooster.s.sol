// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";
import "../src/InfiniteBoost.sol";
import "../src/interfaces/IGauge.sol";
import "../lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";

contract DeployBooster is Script {
    function run() external {
        uint256 privateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(privateKey);

        address itpToken = vm.envAddress("ITP_TOKEN_ADDRESS");
        address veloToken = vm.envAddress("VELO_TOKEN_ADDRESS");
        address lpToken = vm.envAddress("LP_TOKEN_ADDRESS");
        address gaugeAddress = vm.envAddress("GAUGE_ADDRESS");
        address router = vm.envAddress("ROUTER_ADDRESS");
        address oracle = vm.envAddress("ORACULE_ADDRESS");
        address weth = vm.envAddress("USDT_TOKEN_ADDRESS");
        address usdt = vm.envAddress("WETH_TOKEN_ADDRESS");
        address owner = vm.envAddress("OWNER_ADDRESS");

        // Crear instancia del contrato InfiniteBoost
        InfiniteBoost booster = new InfiniteBoost(itpToken, veloToken, weth,  usdt,  router, oracle, owner);

        console.log("Contrato InfiniteBoost desplegado en:", address(booster));
        console.log(" PRIMER OWNER",booster.owner());
        console.log("owner que envia la tx", msg.sender);
        booster.addGauge(lpToken, IGauge(gaugeAddress),200, 9 ether);
        booster.transferOwnership(address(0xb5dB6e5a301E595B76F40319896a8dbDc277CEfB));
        console.log(" SEGUNDO OWNER",booster.owner());
        console.log("Gauge asignado?", booster.isPoolActive(address(lpToken)));

        vm.stopBroadcast();
    }
}
