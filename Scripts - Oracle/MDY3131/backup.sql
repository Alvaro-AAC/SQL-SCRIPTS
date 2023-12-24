DECLARE
    CURSOR c1 IS 
        SELECT *
        FROM cepa
        ORDER BY 2;
    r1 cepa%ROWTYPE;
    
    CURSOR c2 (n number) IS
        SELECT
            b.id_cepa,
            a.nom_cepa,
            COUNT(c.id_pedido) CANTIDAD,
            NVL(SUM(c.cantidad*b.precio), 0) MONTO_PEDIDOS
        FROM cepa a
        JOIN producto b
            ON (a.id_cepa = b.id_cepa)
        LEFT JOIN detalle_pedido c
            ON (b.id_producto = c.id_producto)
        LEFT JOIN pedido d
            ON (c.id_pedido = d.id_pedido)
        WHERE (d.fec_pedido BETWEEN 
            TO_DATE('01-06-2021','DD-MM-YYYY') AND TO_DATE('30-06-2021','DD-MM-YYYY'))
            AND a.id_cepa = n
        GROUP BY (a.nom_cepa, b.id_cepa)
        ORDER BY a.nom_cepa ASC;
        
    v_errcode NUMBER;
    v_errtext errores_proceso_recaudacion.ora_msg%TYPE;
    v_cantidad resumen_ventas_cepa.num_pedidos%TYPE;
    v_monto resumen_ventas_cepa.monto_pedidos%TYPE;
    r2 resumen_ventas_cepa%ROWTYPE;
    v_pctgravamen_dia gravamen.pctgravamen%TYPE;
    v_gravamen NUMBER;
    v_gravamen_dia NUMBER;
    v_dia NUMBER;
    
    TYPE def_desc_arr IS VARRAY(5) OF NUMBER;
    v_desc_arr def_desc_arr;
    
    error_user EXCEPTION;
BEGIN
    v_desc_arr := def_desc_arr(:vb_desc_carmenere, :vb_desc_merlot, :vb_desc_cabernet_suavignon, :vb_desc_syrah, :vb_desc_else);
    DECLARE
        seq_creada EXCEPTION;
        PRAGMA EXCEPTION_INIT(seq_creada, -955);
    BEGIN
        EXECUTE IMMEDIATE 'CREATE SEQUENCE sq_error';
    EXCEPTION
        WHEN seq_creada THEN
            EXECUTE IMMEDIATE 'DROP SEQUENCE sq_error';
            EXECUTE IMMEDIATE 'CREATE SEQUENCE sq_error';
    END;
    EXECUTE IMMEDIATE 'TRUNCATE TABLE resumen_ventas_cepa';
    EXECUTE IMMEDIATE 'TRUNCATE TABLE errores_proceso_recaudacion';
    
    
    
    OPEN c1;    
    LOOP
        FETCH c1 INTO r1;
        EXIT WHEN c1%NOTFOUND;
        v_cantidad := 0;
        v_monto := 0;
        v_gravamen := 0;
        dbms_output.put_line(r1.nom_cepa);
        FOR j_record IN c2(r1.id_cepa) LOOP
            v_cantidad := j_record.cantidad;
            v_monto := j_record.monto_pedidos;
            v_gravamen := 0;
            FOR cur_diario IN (
                SELECT
                    fec_pedido,
                    SUM(c.cantidad*b.precio) suma_dia
                FROM cepa a
                JOIN producto b
                    ON (a.id_cepa = b.id_cepa)
                LEFT JOIN detalle_pedido c
                    ON (b.id_producto = c.id_producto)
                LEFT JOIN pedido d
                    ON (c.id_pedido = d.id_pedido)
                WHERE (d.fec_pedido BETWEEN 
                    TO_DATE('01-06-2021','DD-MM-YYYY') AND TO_DATE('30-06-2021','DD-MM-YYYY'))
                    AND a.id_cepa = j_record.id_cepa
                GROUP BY fec_pedido
            ) LOOP
            BEGIN
                v_dia := EXTRACT(DAY FROM cur_diario.fec_pedido);
                SELECT pctgravamen
                INTO v_pctgravamen_dia
                FROM gravamen
                WHERE cur_diario.suma_dia BETWEEN mto_venta_inf AND mto_venta_sup;
                v_gravamen_dia := ROUND((v_pctgravamen_dia/100)*cur_diario.suma_dia);
                IF (v_gravamen_dia>50000)
                    THEN RAISE error_user;
                END IF;
                v_gravamen := v_gravamen + v_gravamen_dia;
                
            EXCEPTION
                WHEN TOO_MANY_ROWS THEN
                    v_errcode := SQLCODE;
                    v_errtext := SQLERRM;
                    INSERT INTO errores_proceso_recaudacion VALUES(sq_error.nextval, 
                    v_errtext, 'Se encontro mas de un porcentaje de gravamen para el monto');
                WHEN NO_DATA_FOUND THEN
                    v_errcode := SQLCODE;
                    v_errtext := SQLERRM;
                    INSERT INTO errores_proceso_recaudacion VALUES(sq_error.nextval, 
                    v_errtext, 'No se econtro porcentaje de gravamen para el monto el dia: ' || v_dia);
                WHEN ERROR_USER THEN
                    v_errcode := SQLCODE;
                    v_errtext := SQLERRM;
                    v_gravamen := v_gravamen - (v_gravamen_dia - 50000);
                    INSERT INTO errores_proceso_recaudacion VALUES(sq_error.nextval, 
                    v_errtext, 'Se reemplaza el monto calculado de $' || v_gravamen_dia || ' por $50000');
            END;
            END LOOP;
        END LOOP;
        dbms_output.put_line('GRAVAMEN: ' || v_gravamen);
    END LOOP;
    CLOSE c1;
END;