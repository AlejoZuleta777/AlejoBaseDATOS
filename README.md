# Recuperación de Saldos Bancarios con Cursores

## Problema
En el banco ocurrió un incidente donde los triggers dejaron de funcionar.  
Como consecuencia:
- No se actualizaron los saldos
- No se registraron eventos en auditoría
- Las transferencias continuaron registrándose

## Objetivo
Recrear los saldos correctos mediante un procedimiento almacenado usando cursores.

## Solución
Se desarrolló el procedimiento:

```sql
CALL reconstruir_saldos();
