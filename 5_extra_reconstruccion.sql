DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `reconstruir_saldos`()
BEGIN
    DECLARE done INT DEFAULT 0;
    
    DECLARE v_origen VARCHAR(20);
    DECLARE v_destino VARCHAR(20);
    DECLARE v_monto DECIMAL(18,2);

    DECLARE ultima_fecha DATETIME;

    -- Cursor
    DECLARE cur_transferencias CURSOR FOR
        SELECT Cuenta_Origen, Cuenta_Destino, Monto
        FROM transferencias
        WHERE Fecha_Operacion > ultima_fecha
        AND Estado_Transferencia = 'Ejecutada';

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    -- Obtener última fecha válida de auditoría
    SELECT MAX(Fecha_Evento) INTO ultima_fecha FROM auditoria_sql;

    OPEN cur_transferencias;

    read_loop: LOOP
        FETCH cur_transferencias INTO v_origen, v_destino, v_monto;

        IF done THEN
            LEAVE read_loop;
        END IF;

        -- Descontar saldo origen
        UPDATE cuentas
        SET Saldo = Saldo - v_monto
        WHERE Numero_Cuenta = v_origen;

        -- Sumar saldo destino
        UPDATE cuentas
        SET Saldo = Saldo + v_monto
        WHERE Numero_Cuenta = v_destino;

    END LOOP;

    CLOSE cur_transferencias;

END$$
DELIMITER ;
