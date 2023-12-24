VAR vb_desc_carmenere NUMBER;
VAR vb_desc_merlot NUMBER;
VAR vb_desc_cabernet NUMBER;
VAR vb_desc_syrah NUMBER;
VAR vb_desc_else NUMBER;
VAR vb_descto_limit NUMBER;
VAR vb_annyo_mes NUMBER;

DECLARE
    CURSOR c1 IS 
        SELECT *
        FROM cepa
        ORDER BY 2;
    r1 cepa%ROWTYPE;
    CURSOR c2 (n number, v_mes number, v_annyo number) IS
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
            TO_DATE('01-' || v_mes || '-' || v_annyo,'DD-MM-YYYY') AND TO_DATE('30-' || v_mes || '-' || v_annyo,'DD-MM-YYYY'))
            AND a.id_cepa = n
        GROUP BY (a.nom_cepa, b.id_cepa)
        ORDER BY a.nom_cepa ASC;
        
    v_errcode NUMBER;
    v_errtext errores_proceso_recaudacion.ora_msg%TYPE;
    v_cantidad resumen_ventas_cepa.num_pedidos%TYPE;
    r2 resumen_ventas_cepa%ROWTYPE;
    v_pctgravamen_dia gravamen.pctgravamen%TYPE;
    v_gravamen_dia NUMBER;
    v_dia NUMBER;
    v_mes NUMBER;
    v_annyo NUMBER;
    v_descto_dia NUMBER;
    
    TYPE def_desc_arr IS VARRAY(5) OF NUMBER;
    v_desc_arr def_desc_arr;
    TYPE def_arr_delivery IS VARRAY(1) OF NUMBER;
    v_arr_delivery def_arr_delivery;
    
    error_user EXCEPTION;
    PRAGMA EXCEPTION_INIT(error_user, -20001);
BEGIN
    v_arr_delivery := def_arr_delivery(1800);
    --v_desc_arr := def_desc_arr(:vb_desc_carmenere, :vb_desc_merlot, :vb_desc_cabernet, :vb_desc_syrah, :vb_desc_else);
    v_desc_arr := def_desc_arr(23, 21, 19, 17, 15);
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
    v_mes := SUBSTR(:vb_annyo_mes, 5);
    v_annyo := SUBSTR(:vb_annyo_mes, 0, 4);
    OPEN c1;
    LOOP
        FETCH c1 INTO r1;
        EXIT WHEN c1%NOTFOUND;
        v_cantidad := 0;
        r2.monto_pedidos := 0;
        r2.monto_pedidos := 0;
        r2.gravamenes := 0;
        r2.desctos_cepa := 0;
        r2.monto_delivery := 0;
        r2.cepa := r1.nom_cepa;
        r2.num_pedidos := 0;
        FOR j_record IN c2(r1.id_cepa, v_mes, v_annyo) LOOP
            v_cantidad := j_record.cantidad;
            r2.monto_pedidos := j_record.monto_pedidos;
            r2.gravamenes := 0;
            r2.desctos_cepa := 0;
            r2.monto_delivery := 0;
            r2.num_pedidos := j_record.cantidad;
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
                    TO_DATE('01-' || v_mes || '-' || v_annyo,'DD-MM-YYYY') AND TO_DATE('30-' || v_mes || '-' || v_annyo,'DD-MM-YYYY'))
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
                    r2.gravamenes := r2.gravamenes + v_gravamen_dia;
                    CASE j_record.id_cepa
                        WHEN 3 THEN v_descto_dia := (v_desc_arr(1)/100)*cur_diario.suma_dia;
                        WHEN 5 THEN v_descto_dia := (v_desc_arr(2)/100)*cur_diario.suma_dia;
                        WHEN 4 THEN v_descto_dia := (v_desc_arr(3)/100)*cur_diario.suma_dia;
                        WHEN 2 THEN v_descto_dia := (v_desc_arr(4)/100)*cur_diario.suma_dia;
                        ELSE v_descto_dia := (v_desc_arr(5)/100)*cur_diario.suma_dia;
                    END CASE;
                    r2.desctos_cepa := r2.desctos_cepa + v_descto_dia;
                    IF (v_descto_dia>:vb_descto_limite)
                        THEN RAISE error_user;
                    END IF;
                EXCEPTION
                    WHEN TOO_MANY_ROWS THEN
                        v_errcode := SQLCODE;
                        v_errtext := SQLERRM;
                        INSERT INTO errores_proceso_recaudacion VALUES(sq_error.nextval, 
                        v_errtext, 'Se encontro mas de un porcentaje de gravamen para el monto de los pedidos del dia: ' || 
                            TO_CHAR(v_dia, '00') || '/' || TO_CHAR(v_mes, '00') || '/' || v_annyo);
                        
                        CASE j_record.id_cepa
                            WHEN 3 THEN v_descto_dia := (v_desc_arr(1)/100)*cur_diario.suma_dia;
                            WHEN 5 THEN v_descto_dia := (v_desc_arr(2)/100)*cur_diario.suma_dia;
                            WHEN 4 THEN v_descto_dia := (v_desc_arr(3)/100)*cur_diario.suma_dia;
                            WHEN 2 THEN v_descto_dia := (v_desc_arr(4)/100)*cur_diario.suma_dia;
                            ELSE v_descto_dia := (v_desc_arr(5)/100)*cur_diario.suma_dia;
                        END CASE;
                        r2.desctos_cepa := r2.desctos_cepa + v_descto_dia;
                        IF (v_descto_dia>:vb_descto_limite)
                            THEN RAISE error_user;
                        END IF;
                    
                    WHEN NO_DATA_FOUND THEN
                        v_errcode := SQLCODE;
                        v_errtext := SQLERRM;
                        INSERT INTO errores_proceso_recaudacion VALUES(sq_error.nextval, 
                        v_errtext, 'No se econtro porcentaje de gravamen para el monto de los pedidos del dia: ' || 
                            TO_CHAR(v_dia, '00') || '/' || TO_CHAR(v_mes, '00') || '/' || v_annyo);
                        
                        CASE j_record.id_cepa
                            WHEN 3 THEN v_descto_dia := (v_desc_arr(1)/100)*cur_diario.suma_dia;
                            WHEN 5 THEN v_descto_dia := (v_desc_arr(2)/100)*cur_diario.suma_dia;
                            WHEN 4 THEN v_descto_dia := (v_desc_arr(3)/100)*cur_diario.suma_dia;
                            WHEN 2 THEN v_descto_dia := (v_desc_arr(4)/100)*cur_diario.suma_dia;
                            ELSE v_descto_dia := (v_desc_arr(5)/100)*cur_diario.suma_dia;
                        END CASE;
                        r2.desctos_cepa := r2.desctos_cepa + v_descto_dia;
                        IF (v_descto_dia>:vb_descto_limite)
                            THEN RAISE error_user;
                        END IF;
                        
                    WHEN ERROR_USER THEN
                        v_errcode := SQLCODE;
                        v_errtext := SQLERRM;
                        r2.desctos_cepa := r2.desctos_cepa - (v_descto_dia - 50000);
                        INSERT INTO errores_proceso_recaudacion VALUES(sq_error.nextval, 
                        v_errtext || 'Monto de descuento sobrepasa el limite permitido', 
                        'Se reemplaza el monto calculado de $' || v_descto_dia || ' por $50000');
                END;
            END LOOP;
            r2.monto_delivery := j_record.cantidad*v_arr_delivery(1);
        END LOOP;
        r2.monto_descuentos := r2.gravamenes + r2.desctos_cepa + r2.monto_delivery;
        r2.total_recaudacion := r2.monto_pedidos - r2.monto_descuentos;
        INSERT INTO resumen_ventas_cepa VALUES(r2.cepa, r2.num_pedidos, r2.monto_pedidos,
                                               r2.gravamenes, r2.desctos_cepa, r2.monto_delivery,
                                               r2.monto_descuentos, r2.total_recaudacion);
    END LOOP;
    CLOSE c1;
    COMMIT;
EXCEPTION
    WHEN others THEN
        dbms_output.put_line(SQLCODE || ' ' || SQLERRM);
END;