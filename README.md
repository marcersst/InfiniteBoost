# InfiniteBoost

## Descripción

InfiniteBoost es un contrato inteligente que actúa como intermediario entre los usuarios que depositan tokens LP y los contratos Gauge. Su objetivo principal es maximizar los rendimientos para los usuarios, pagando recompensas en `boostRewardToken` con un porcentaje adicional sobre las recompensas originales en `baseRewardToken`.

## Características

- **Boosting de recompensas**: Incrementa las recompensas de los usuarios con un porcentaje adicional
- **Gestión de múltiples LPs**: Soporta diferentes tokens LP y sus Gauges asociados
- **Sistema de pools de recompensas**: Control preciso sobre la distribución de tokens
- **Mecanismos de seguridad**: Protección contra reentrancia y sistema de pausa para emergencias

## Estructura del Contrato

### Componentes Principales

- **Tokens y Contratos**:
  - `boostRewardToken`: Token con el que se paga a los usuarios
  - `baseRewardToken`: Token original de recompensas que obtiene el DAO
  - `weth` y `connectorToken`: Tokens usados como conectores para conversiones
  - `router`: Contrato para operaciones de intercambio
  - `oracle`: Contrato para obtener tasas de conversión

- **Estructuras**:
  ```solidity
  struct RewardPool {
      uint256 totalRewards;        // Total de recompensas asignadas al pool
      uint256 distributedRewards;  // Recompensas ya distribuidas
      uint256 baseRewardTokenEarned; // Recompensas en token base ganadas
  }
  ```

### Funcionalidades para Usuarios

- **Depositar tokens LP**: Los usuarios pueden depositar sus tokens LP para recibir recompensas mejoradas
- **Retirar tokens LP**: Retiro de fondos con una pequeña comisión
- **Reclamar recompensas**: Obtener las recompensas acumuladas con el boost aplicado
- **Retiros de emergencia**: Disponible cuando el contrato está en pausa

### Funciones Administrativas

- **Gestión de Gauges**: Añadir o eliminar Gauges para tokens LP
- **Configuración de parámetros**: Ajustar comisiones y porcentajes de boost
- **Control de fondos**: Gestionar las recompensas y las comisiones acumuladas
- **Sistema de pausa**: Detener el contrato en caso de emergencia

## Flujo de Funcionamiento

1. **Depósito**:
   - Los usuarios depositan tokens LP
   - Los tokens son enviados al Gauge correspondiente
   - Se actualiza el balance del usuario

2. **Acumulación de Recompensas**:
   - Las recompensas se generan en el Gauge
   - El contrato calcula las recompensas equivalentes en `boostRewardToken`
   - Se aplica el boost configurado

3. **Retiro y Reclamo**:
   - Los usuarios pueden retirar sus tokens LP
   - Se aplica una comisión que va al DAO
   - Las recompensas se pagan con el boost adicional

## Seguridad

El contrato implementa varias medidas de seguridad:

- Protección contra reentrancia en todas las funciones críticas
- Sistema de pausa para detener operaciones en caso de emergencia
- Verificaciones de balances para prevenir ataques
- Control de asignación de recompensas

## Licencia

Este proyecto está licenciado bajo MIT - ver el archivo LICENSE para más detalles.

## Contribuciones

Las contribuciones son bienvenidas. Por favor, abre un issue o una pull request para sugerir cambios o mejoras.
