USE banco;

DELIMITER $$

CREATE PROCEDURE sp_crear_cliente(
    IN p_nombre VARCHAR(100),
    IN p_identificacion VARCHAR(20),
    IN p_correo VARCHAR(100)
)
BEGIN
    INSERT INTO clientes(nombre, identificacion, correo)
    VALUES(p_nombre, p_identificacion, p_correo);
END$$

CREATE PROCEDURE sp_crear_cuenta(
    IN p_numero INT,
    IN p_tipo VARCHAR(50),
    IN p_saldo DECIMAL(12,2),
    IN p_id_cliente INT
)
BEGIN
    INSERT INTO cuentas(numero_cuenta, tipo_cuenta, saldo, estado_cuenta, id_cliente)
    VALUES(p_numero, p_tipo, p_saldo, 'Activa', p_id_cliente);
END$$

CREATE PROCEDURE sp_realizar_transferencia(
    IN p_origen INT,
    IN p_destino INT,
    IN p_monto DECIMAL(12,2)
)
BEGIN
    INSERT INTO transferencias(
        cuenta_origen,
        cuenta_destino,
        monto,
        fecha,
        estado_transferencia
    )
    VALUES(
        p_origen,
        p_destino,
        p_monto,
        NOW(),
        'En espera'
    );
END$$

CREATE PROCEDURE sp_aprobar_transferencia(
    IN p_id INT
)
BEGIN
    UPDATE transferencias
    SET estado_transferencia = 'Ejecutada'
    WHERE id_transferencia = p_id;
END$$

CREATE PROCEDURE sp_consultar_saldo(
    IN p_cuenta INT
)
BEGIN
    SELECT saldo
    FROM cuentas
    WHERE numero_cuenta = p_cuenta;
END$$

DELIMITER ;
