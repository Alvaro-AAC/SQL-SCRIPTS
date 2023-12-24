VARIABLE vb_min NUMBER;
DECLARE
    v_id cliente_todosuma.NRO_CLIENTE%TYPE;
    v_run_buscar cliente.NUMRUN%TYPE := 23309886; -- &Rut
    v_run cliente_todosuma.RUN_CLIENTE%TYPE;
    v_nombre cliente_todosuma.NOMBRE_CLIENTE%TYPE;
    v_tipo cliente_todosuma.TIPO_CLIENTE%TYPE;
    v_monto_credito cliente_todosuma.MONTO_SOLIC_CREDITOS%TYPE;
    v_monto_bono cliente_todosuma.MONTO_PESOS_TODOSUMA%TYPE;
BEGIN
    SELECT
        c.nro_cliente,
        (SELECT TO_CHAR(numrun, '999,999,999') || '-' || dvrun FROM cliente WHERE numrun = v_run_buscar),
        UPPER(pnombre || ' ' || NVL(snombre, '') || ' ' || appaterno || ' ' || NVL(apmaterno, '')),
        tc.nombre_tipo_cliente,
        SUM(NVL(cc.monto_solicitado, 0))
            INTO v_id, v_run, v_nombre, v_tipo, v_monto_credito
    FROM cliente c
    JOIN tipo_cliente tc ON (c.cod_tipo_cliente = tc.cod_tipo_cliente)
    JOIN credito_cliente cc ON (c.nro_cliente = cc.nro_cliente)
    WHERE numrun = v_run_buscar
    GROUP BY 
        c.nro_cliente,
        TO_CHAR(c.numrun, '999,999,999') || '-' || dvrun,
        UPPER(pnombre || ' ' || NVL(snombre, '') || ' ' || appaterno || ' ' || NVL(apmaterno, '')),
        tc.nombre_tipo_cliente;
    v_monto_bono := (v_monto_credito/100000)*(1200 +
        CASE
            WHEN (v_monto_credito <= TO_NUMBER(:vb_min)) AND LOWER(v_tipo) = 'trabajadores independiente'
                THEN 100
            WHEN (v_monto_credito BETWEEN 1000001 AND 3000000) AND LOWER(v_tipo) = 'trabajadores independiente'
                THEN 300
            WHEN (v_monto_credito > 3000000) AND LOWER(v_tipo) = 'trabajadores independiente'
                THEN 550
            ELSE 0
        END);
    dbms_output.put_line(v_monto_bono || ' ' || TO_NUMBER(:vb_min));
END;

-- SELECT * FROM cliente_todosuma;

-- DELETE FROM cliente_todosuma;