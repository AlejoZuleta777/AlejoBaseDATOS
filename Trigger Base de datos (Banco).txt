CASO #1


USE Banco;

DELIMITER //

CREATE TRIGGER tg_validar_fondos_transferencia
BEFORE INSERT ON Transferencias
FOR EACH ROW
BEGIN
    DECLARE saldo_actual DECIMAL(18, 2);

    SELECT Saldo INTO saldo_actual 
    FROM Cuentas 
    WHERE Numero_Cuenta = NEW.Cuenta_Origen;

    IF saldo_actual < NEW.Monto THEN
        -- Si no hay fondos, lanzamos un error para cancelar la inserción
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Operación cancelada: Fondos insuficientes en la cuenta origen.';
    ELSE

        UPDATE Cuentas 
        SET Saldo = Saldo - NEW.Monto 
        WHERE Numero_Cuenta = NEW.Cuenta_Origen;

        UPDATE Cuentas 
        SET Saldo = Saldo + NEW.Monto 
        WHERE Numero_Cuenta = NEW.Cuenta_Destino;
    END IF;
END //

DELIMITER ;



--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

CASO #2


USE Banco;

DELIMITER //

CREATE TRIGGER tg_validar_aprobacion_transferencia
BEFORE UPDATE ON Transferencias
FOR EACH ROW
BEGIN
    DECLARE saldo_actual DECIMAL(18, 2);
    IF NEW.Estado_Transferencia = 'Ejecutada' AND OLD.Estado_Transferencia = 'En espera de aprobación' THEN
        
        SELECT Saldo INTO saldo_actual 
        FROM Cuentas 
        WHERE Numero_Cuenta = NEW.Cuenta_Origen;

        IF saldo_actual < NEW.Monto THEN
            SIGNAL SQLSTATE '45000' 
            SET MESSAGE_TEXT = 'Error de Aprobación: Fondos insuficientes tras operaciones previas.';
        ELSE
            UPDATE Cuentas 
            SET Saldo = Saldo - NEW.Monto 
            WHERE Numero_Cuenta = NEW.Cuenta_Origen;

            UPDATE Cuentas 
            SET Saldo = Saldo + NEW.Monto 
            WHERE Numero_Cuenta = NEW.Cuenta_Destino;
            
            SET NEW.Fecha_Operacion = CURRENT_TIMESTAMP;
        END IF;
        
    END IF;
END //

DELIMITER ;


