USE banco;



-- =========================================
-- ========= SERVICIOS CLIENTES ============
-- =========================================

CREATE PROCEDURE sp_crear_cliente(
    IN p_nombre VARCHAR(100),
    IN p_identificacion VARCHAR(20),
    IN p_correo VARCHAR(100),
    IN p_telefono VARCHAR(15),
    IN p_direccion VARCHAR(150),
    IN p_tipo VARCHAR(20)
)
BEGIN
    INSERT INTO clientes(
        nombre,
        identificacion,
        correo,
        telefono,
        direccion,
        tipo_cliente
    )
    VALUES(
        p_nombre,
        p_identificacion,
        p_correo,
        p_telefono,
        p_direccion,
        p_tipo
    );
END$$


CREATE PROCEDURE sp_actualizar_cliente(
    IN p_id INT,
    IN p_nombre VARCHAR(100),
    IN p_correo VARCHAR(100)
)
BEGIN
    UPDATE clientes
    SET nombre = p_nombre,
        correo = p_correo
    WHERE id_cliente = p_id;
END$$


CREATE PROCEDURE sp_eliminar_cliente(
    IN p_id INT
)
BEGIN
    DELETE FROM clientes
    WHERE id_cliente = p_id;
END$$


CREATE PROCEDURE sp_buscar_cliente(
    IN p_id INT
)
BEGIN
    SELECT *
    FROM clientes
    WHERE id_cliente = p_id;
END$$


CREATE PROCEDURE sp_listar_clientes()
BEGIN
    SELECT *
    FROM clientes;
END$$

-- =========================================
-- ============ SERVICIOS CUENTAS ==========
-- =========================================

CREATE PROCEDURE sp_crear_cuenta(
    IN p_numero INT,
    IN p_tipo VARCHAR(50),
    IN p_saldo DECIMAL(12,2),
    IN p_id_cliente INT
)
BEGIN
    INSERT INTO cuentas(
        numero_cuenta,
        tipo_cuenta,
        saldo,
        estado_cuenta,
        id_cliente
    )
    VALUES(
        p_numero,
        p_tipo,
        p_saldo,
        'Activa',
        p_id_cliente
    );
END$$


CREATE PROCEDURE sp_cerrar_cuenta(
    IN p_numero INT
)
BEGIN
    UPDATE cuentas
    SET estado_cuenta = 'Cerrada'
    WHERE numero_cuenta = p_numero;
END$$


CREATE PROCEDURE sp_activar_cuenta(
    IN p_numero INT
)
BEGIN
    UPDATE cuentas
    SET estado_cuenta = 'Activa'
    WHERE numero_cuenta = p_numero;
END$$


CREATE PROCEDURE sp_consultar_saldo(
    IN p_numero INT
)
BEGIN
    SELECT saldo
    FROM cuentas
    WHERE numero_cuenta = p_numero;
END$$


CREATE PROCEDURE sp_listar_cuentas()
BEGIN
    SELECT *
    FROM cuentas;
END$$


CREATE PROCEDURE sp_depositar(
    IN p_numero INT,
    IN p_monto DECIMAL(12,2)
)
BEGIN
    UPDATE cuentas
    SET saldo = saldo + p_monto
    WHERE numero_cuenta = p_numero;
END$$


CREATE PROCEDURE sp_retirar(
    IN p_numero INT,
    IN p_monto DECIMAL(12,2)
)
BEGIN
    UPDATE cuentas
    SET saldo = saldo - p_monto
    WHERE numero_cuenta = p_numero;
END$$


CREATE PROCEDURE sp_transferir(
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

-- =========================================
-- ======== SERVICIOS TRANSFERENCIAS =======
-- =========================================

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


CREATE PROCEDURE sp_cancelar_transferencia(
    IN p_id INT
)
BEGIN
    UPDATE transferencias
    SET estado_transferencia = 'Cancelada'
    WHERE id_transferencia = p_id;
END$$


CREATE PROCEDURE sp_listar_transferencias()
BEGIN
    SELECT *
    FROM transferencias;
END$$


CREATE PROCEDURE sp_transferencias_pendientes()
BEGIN
    SELECT *
    FROM transferencias
    WHERE estado_transferencia = 'En espera';
END$$

-- =========================================
-- ============ SERVICIOS PRESTAMOS ========
-- =========================================

CREATE PROCEDURE sp_solicitar_prestamo(
    IN p_monto DECIMAL(12,2),
    IN p_tasa DECIMAL(5,2),
    IN p_plazo INT,
    IN p_cliente INT
)
BEGIN
    INSERT INTO prestamos(
        monto_solicitado,
        monto_aprobado,
        tasa_interes,
        plazo_meses,
        estado_prestamo,
        id_cliente
    )
    VALUES(
        p_monto,
        0,
        p_tasa,
        p_plazo,
        'En estudio',
        p_cliente
    );
END$$


CREATE PROCEDURE sp_aprobar_prestamo(
    IN p_id INT,
    IN p_monto_aprobado DECIMAL(12,2)
)
BEGIN
    UPDATE prestamos
    SET monto_aprobado = p_monto_aprobado,
        estado_prestamo = 'Aprobado'
    WHERE id_prestamo = p_id;
END$$


CREATE PROCEDURE sp_rechazar_prestamo(
    IN p_id INT
)
BEGIN
    UPDATE prestamos
    SET estado_prestamo = 'Rechazado'
    WHERE id_prestamo = p_id;
END$$


CREATE PROCEDURE sp_pagar_prestamo(
    IN p_id INT
)
BEGIN
    UPDATE prestamos
    SET estado_prestamo = 'Pagado'
    WHERE id_prestamo = p_id;
END$$


CREATE PROCEDURE sp_consultar_prestamos()
BEGIN
    SELECT *
    FROM prestamos;
END$$

-- =========================================
-- ============= SERVICIOS USUARIOS ========
-- =========================================

CREATE PROCEDURE sp_crear_usuario(
    IN p_nombre VARCHAR(100),
    IN p_rol VARCHAR(50),
    IN p_estado VARCHAR(20),
    IN p_cliente INT
)
BEGIN
    INSERT INTO usuarios(
        nombre,
        rol,
        estado,
        id_cliente
    )
    VALUES(
        p_nombre,
        p_rol,
        p_estado,
        p_cliente
    );
END$$


CREATE PROCEDURE sp_actualizar_usuario(
    IN p_id INT,
    IN p_nombre VARCHAR(100),
    IN p_rol VARCHAR(50)
)
BEGIN
    UPDATE usuarios
    SET nombre = p_nombre,
        rol = p_rol
    WHERE id_usuario = p_id;
END$$


CREATE PROCEDURE sp_desactivar_usuario(
    IN p_id INT
)
BEGIN
    UPDATE usuarios
    SET estado = 'Inactivo'
    WHERE id_usuario = p_id;
END$$


CREATE PROCEDURE sp_listar_usuarios()
BEGIN
    SELECT *
    FROM usuarios;
END$$

-- =========================================
-- =============== REPORTES ================
-- =========================================

CREATE PROCEDURE sp_reporte_transferencias()
BEGIN
    SELECT *
    FROM transferencias;
END$$


CREATE PROCEDURE sp_reporte_clientes()
BEGIN
    SELECT *
    FROM clientes;
END$$


CREATE PROCEDURE sp_reporte_prestamos()
BEGIN
    SELECT *
    FROM prestamos;
END$$


CREATE PROCEDURE sp_cuentas_con_mas_dinero()
BEGIN
    SELECT *
    FROM cuentas
    ORDER BY saldo DESC;
END$$

-- =========================================
-- ============== SERVICIOS EXTRA ==========
-- =========================================

CREATE PROCEDURE sp_validar_estado_cuenta(
    IN p_numero INT
)
BEGIN
    SELECT estado_cuenta
    FROM cuentas
    WHERE numero_cuenta = p_numero;
END$$


CREATE PROCEDURE sp_buscar_transferencia(
    IN p_id INT
)
BEGIN
    SELECT *
    FROM transferencias
    WHERE id_transferencia = p_id;
END$$


CREATE PROCEDURE sp_buscar_usuario(
    IN p_id INT
)
BEGIN
    SELECT *
    FROM usuarios
    WHERE id_usuario = p_id;
END$$


CREATE PROCEDURE sp_clientes_empresariales()
BEGIN
    SELECT *
    FROM clientes
    WHERE tipo_cliente = 'Empresa';
END$$


CREATE PROCEDURE sp_clientes_persona()
BEGIN
    SELECT *
    FROM clientes
    WHERE tipo_cliente = 'Persona';
END$$


CREATE PROCEDURE sp_transferencias_ejecutadas()
BEGIN
    SELECT *
    FROM transferencias
    WHERE estado_transferencia = 'Ejecutada';
END$$


CREATE PROCEDURE sp_transferencias_canceladas()
BEGIN
    SELECT *
    FROM transferencias
    WHERE estado_transferencia = 'Cancelada';
END$$


CREATE PROCEDURE sp_prestamos_aprobados()
BEGIN
    SELECT *
    FROM prestamos
    WHERE estado_prestamo = 'Aprobado';
END$$


CREATE PROCEDURE sp_prestamos_rechazados()
BEGIN
    SELECT *
    FROM prestamos
    WHERE estado_prestamo = 'Rechazado';
END$$


CREATE PROCEDURE sp_prestamos_pagados()
BEGIN
    SELECT *
    FROM prestamos
    WHERE estado_prestamo = 'Pagado';
END$$

DELIMITER ;
