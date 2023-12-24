DECLARE
    v_utilidades NUMBER(20) := 200000000;
    v_porc_utilidades NUMBER(3) := 30;
    v_anno_proceso NUMBER(4);
    v_max_id_emp EMPLEADO.id_emp%TYPE;
    v_iterator EMPLEADO.id_emp%TYPE;
    v_id_emp EMPLEADO.id_emp%TYPE;
    v_sueldo_base EMPLEADO.sueldo_base%TYPE;
    v_valor_bonif_utilidad BONIF_POR_UTILIDAD.valor_bonif_utilidad%TYPE;
    v_ts1 NUMBER(14) := 320000;
    v_te1 NUMBER(14) := 600000;
    v_porc1 NUMBER(6, 3) := 35;
    v_cant1 NUMBER(4) := 0;
    v_ts2 NUMBER(14) := 600001;
    v_te2 NUMBER(14) := 1300000;
    v_porc2 NUMBER(6, 3):= 25;
    v_cant2 NUMBER(4) := 0;
    v_ts3 NUMBER(14) := 1300001;
    v_te3 NUMBER(14) := 1800000;
    v_porc3 NUMBER(6, 3) := 20;
    v_cant3 NUMBER(4) := 0;
    v_ts4 NUMBER(14) := 1800001;
    v_te4 NUMBER(14) := 2200000;
    v_porc4 NUMBER(6, 3) := 15;
    v_cant4 NUMBER(4) := 0;
    v_ts5 NUMBER(14) := 2200001;
    v_porc5 NUMBER(6, 3) := 5;
    v_cant5 NUMBER(4) := 0;
BEGIN
    -- Parametrizar año actual
    SELECT EXTRACT(YEAR FROM sysdate) INTO v_anno_proceso FROM dual;
    -- Parametrizar el id menor y el id mayor
    SELECT MIN(id_emp), MAX(id_emp)INTO v_iterator, v_max_id_emp FROM empleado;
    -- Calculo de porcentaje en porcentaje, es decir, el porcentaje del tramo en el porcentaje de las utilidades
    v_porc1 := (v_porc1*v_porc_utilidades)/10000;
    v_porc2 := (v_porc2*v_porc_utilidades)/10000;
    v_porc3 := (v_porc3*v_porc_utilidades)/10000;
    v_porc4 := (v_porc4*v_porc_utilidades)/10000;
    v_porc5 := (v_porc5*v_porc_utilidades)/10000;
    -- Determinar la cantidad e empleados en el tramo 1
    SELECT COUNT(id_emp)
    INTO v_cant1
    FROM EMPLEADO
    WHERE sueldo_base BETWEEN v_ts1 AND v_te1;
    -- Determinar la cantidad e empleados en el tramo 2
    SELECT COUNT(id_emp)
    INTO v_cant2
    FROM EMPLEADO
    WHERE sueldo_base BETWEEN v_ts2 AND v_te2;
    -- Determinar la cantidad e empleados en el tramo 3
    SELECT COUNT(id_emp)
    INTO v_cant3
    FROM EMPLEADO
    WHERE sueldo_base BETWEEN v_ts3 AND v_te3;
    -- Determinar la cantidad e empleados en el tramo 4
    SELECT COUNT(id_emp)
    INTO v_cant4
    FROM EMPLEADO
    WHERE sueldo_base BETWEEN v_ts4 AND v_te4;
    -- Determinar la cantidad e empleados en el tramo 5
    SELECT COUNT(id_emp)
    INTO v_cant5
    FROM EMPLEADO
    WHERE sueldo_base > v_ts5;
    -- Bucle iterando cada empleado por medio del ID
    WHILE v_iterator < v_max_id_emp+1 LOOP
        -- Extraer el id y el sueldo base de cada empledao
        SELECT id_emp, sueldo_base
        INTO v_id_emp, v_sueldo_base
        FROM empleado
        WHERE id_emp = v_iterator;
        -- Control de flujo para determinar el bono de cada empleado
        CASE
            WHEN v_sueldo_base BETWEEN v_ts1 AND v_te1
                THEN v_valor_bonif_utilidad := (v_utilidades*v_porc1)/v_cant1;
            WHEN v_sueldo_base > v_ts2 AND v_sueldo_base < v_te2
                THEN v_valor_bonif_utilidad := v_utilidades*v_porc2/v_cant2;
            WHEN v_sueldo_base > v_ts3 AND v_sueldo_base < v_te3
                THEN v_valor_bonif_utilidad := v_utilidades*v_porc3/v_cant3;
            WHEN v_sueldo_base > v_ts4 AND v_sueldo_base < v_te4
                THEN v_valor_bonif_utilidad := v_utilidades*v_porc4/v_cant4;
            WHEN v_sueldo_base > v_ts5
                THEN v_valor_bonif_utilidad := v_utilidades*v_porc5/v_cant5;
            ELSE v_valor_bonif_utilidad := 0;
        END CASE;
        -- Truncar el valor del bono
        v_valor_bonif_utilidad := TRUNC(v_valor_bonif_utilidad);
        -- Aumentar el valor del iterador
        v_iterator := v_iterator+10;
        -- Mostrar en pantalla para testing
        dbms_output.put_line(v_id_emp || ' ' || v_sueldo_base || ' ' || v_valor_bonif_utilidad);
        -- Insertar en la tabla bonif_por_utilidad los valores indicados
        INSERT INTO bonif_por_utilidad VALUES (v_anno_proceso, v_id_emp, v_sueldo_base, v_valor_bonif_utilidad);
    END LOOP;
END;