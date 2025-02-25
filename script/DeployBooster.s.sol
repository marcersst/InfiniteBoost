// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";
import "../src/BoosterVeloLp.sol";
import "../src/interfaces/IGauge.sol";
import "../lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";

contract DeployBooster is Script {
    function run() external {
        uint256 privateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(privateKey);

        // Cargar direcciones desde variables de entorno
        address itpToken = vm.envAddress("ITP_TOKEN_ADDRESS");
        address veloToken = vm.envAddress("VELO_TOKEN_ADDRESS");
        address lpToken = vm.envAddress("LP_TOKEN_ADDRESS");
        address gaugeAddress = vm.envAddress("GAUGE_ADDRESS");
        address router = vm.envAddress("ROUTER_ADDRESS");
        address oracle = vm.envAddress("ORACULE_ADDRESS");
        address owner = vm.envAddress("OWNER_ADDRESS");

        // Crear instancia del contrato BoosterVeloLp
        BoosterVeloLp booster = new BoosterVeloLp(itpToken, veloToken, router, oracle, owner);

        console.log("Contrato BoosterVeloLp desplegado en:", address(booster));
        console.log(" PRIMER OWNER",booster.owner());
        console.log("owner que envia la tx", msg.sender);
        booster.addGauge(lpToken, IGauge(gaugeAddress),200);
        booster.transferOwnership(address(0xb5dB6e5a301E595B76F40319896a8dbDc277CEfB));
        console.log(" SEGUNDO OWNER",booster.owner());
        console.log("Gauge asignado?", booster.isActivePool(address(lpToken)));

        vm.stopBroadcast();
    }
}
/** 
== Logs ==
  Contrato BoosterVeloLp desplegado en: 0x4CD8574D6165EaA5fc514FfCCAC2489047e9e857
   PRIMER OWNER 0xD4799210E0891DC4Ef8E28789a6bB74212310041
  owner que envia la tx 0x3fC2513f0093fF4Ffeed4692e822c4108eC87919
   SEGUNDO OWNER 0xb5dB6e5a301E595B76F40319896a8dbDc277CEfB
  Gauge asignado? true
*/