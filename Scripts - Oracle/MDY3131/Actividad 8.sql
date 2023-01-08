VAR vb_5uf NUMBER;
VAR vb_ipc NUMBER;

EXEC :vb_5uf := 101299;
EXEC :vb_ipc := 2.73;

DECLARE
    CURSOR cur_prod IS 
        SELECT
            *
        FROM producto_inversion_socio
        ORDER BY nro_socio, nro_solic_prod
    ;
    v_reg producto_inversion_socio%ROWTYPE;
    TYPE def_arr IS VARRAY(2) OF NUMBER;
    v_varray def_arr;
    v_reajuste NUMBER(20);
BEGIN
    v_varray := def_arr(:vb_5uf, :vb_ipc);
    OPEN cur_prod;
    FETCH cur_prod INTO v_reg;
    WHILE (cur_prod%FOUND) LOOP
        v_reajuste := ROUND(v_reg.monto_total_ahorrado * v_varray(2)/100)+v_reg.monto_total_ahorrado;
        dbms_output.put_line(v_reg.nro_solic_prod || ' ' || v_reg.nro_socio || ' ' || 
                            v_reg.monto_total_ahorrado || ' ' || v_reajuste);
        FETCH cur_prod INTO v_reg;
    END LOOP;
    CLOSE cur_prod;
END;