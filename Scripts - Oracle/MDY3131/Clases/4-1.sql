VAR vb_anno_proceso NUMBER;
VAR vb_comuna_1 VARCHAR2;
VAR vb_val_extra_comuna_1 NUMBER;
VAR vb_comuna_2 VARCHAR2;
VAR vb_val_extra_comuna_2 NUMBER;
VAR vb_comuna_3 VARCHAR2;
VAR vb_val_extra_comuna_3 NUMBER;
VAR vb_comuna_4 VARCHAR2;
VAR vb_val_extra_comuna_4 NUMBER;
VAR vb_comuna_5 VARCHAR2;
VAR vb_val_extra_comuna_5 NUMBER;
DECLARE
    v_id_emp proy_movilizacion.id_emp%TYPE;
    v_numrun_emp proy_movilizacion.numrun_emp%TYPE;
    v_dvrun_emp proy_movilizacion.dvrun_emp%TYPE;
    v_nombre_empleado proy_movilizacion.nombre_empleado%TYPE;
    v_nombre_comuna proy_movilizacion.nombre_comuna%TYPE;
    v_sueldo_base proy_movilizacion.sueldo_base%TYPE;
    v_porc_movil_normal proy_movilizacion.porc_movil_normal%TYPE;
    v_valor_movil_normal proy_movilizacion.valor_movil_normal%TYPE;
    v_valor_movil_extra proy_movilizacion.valor_movil_extra%TYPE;
    v_valor_total_movil proy_movilizacion.valor_total_movil%TYPE;
    v_cant_emp NUMBER(4);
DECLARE
    v_id_emp proy_movilizacion.id_emp%TYPE;
    v_numrun_emp proy_movilizacion.numrun_emp%TYPE;
    v_dvrun_emp proy_movilizacion.dvrun_emp%TYPE;
    v_nombre_empleado proy_movilizacion.nombre_empleado%TYPE;
    v_nombre_comuna proy_movilizacion.nombre_comuna%TYPE;
    v_sueldo_base proy_movilizacion.sueldo_base%TYPE;
    v_porc_movil_normal proy_movilizacion.porc_movil_normal%TYPE;
    v_valor_movil_normal proy_movilizacion.valor_movil_normal%TYPE;
    v_valor_movil_extra proy_movilizacion.valor_movil_extra%TYPE;
    v_valor_total_movil proy_movilizacion.valor_total_movil%TYPE;
    v_cant_emp NUMBER(4);
BEGIN
    SELECT COUNT(id_emp) INTO v_cant_emp FROM empleado;
    SELECT
        EXTRACT(YEAR FROM sysdate),
        id_emp,
        numrun_emp,
        dvrun_emp,
        INITCAP(pnombre_emp || ' ' || NVL(snombre_emp, '') || ' ' || appaterno_emp || ' ' || apmaterno_emp),
        nombre_comuna,
        sueldo_base,
        TRUNC(sueldo_base/100000),
        (TRUNC(sueldo_base/10000)/100)*sueldo_base,
        CASE LOWER(b.nombre_comuna)
            WHEN LOWER(/*:vb_comuna_1*/'María pinto') THEN /*:vb_val_extra_comuna_1*/ 20000
            WHEN LOWER(/*:vb_comuna_2*/'Curacaví') THEN /*:vb_val_extra_comuna_2*/ 25000
            WHEN LOWER(/*:vb_comuna_3*/'Talagante') THEN /*:vb_val_extra_comuna_3*/ 30000
            WHEN LOWER(/*:vb_comuna_4*/'El monte') THEN /*:vb_val_extra_comuna_4*/ 35000
            WHEN LOWER(/*:vb_comuna_5*/'Buin') THEN /*:vb_val_extra_comuna_5*/ 40000
            ELSE 0
        END
    INTO :vb_anno_proceso, v_id_emp, v_numrun_emp, v_dvrun_emp, v_nombre_empleado, v_nombre_comuna, v_sueldo_base,
        v_porc_movil_normal, v_valor_movil_normal, v_valor_movil_extra
    FROM empleado a
    JOIN comuna b ON (a.id_comuna = b.id_comuna)
    WHERE id_emp = 100;
    v_valor_total_movil := v_valor_movil_normal + v_valor_movil_extra;
    INSERT INTO proy_movilizacion VALUES
    (:vb_anno_proceso, v_id_emp, v_numrun_emp, v_dvrun_emp, v_nombre_empleado, 
    v_nombre_comuna, v_sueldo_base, v_porc_movil_normal, v_valor_movil_normal, 
    v_valor_movil_extra, v_valor_total_movil);
    dbms_output.put_line(v_cant_emp || ' ' ||:vb_anno_proceso || ' ' || v_id_emp 
        || ' ' || v_numrun_emp || ' ' || v_dvrun_emp || ' ' || v_nombre_empleado || ' ' || v_nombre_comuna
        || ' ' || v_sueldo_base || ' ' || v_porc_movil_normal || ' ' || v_valor_movil_normal
        || ' ' || v_valor_movil_extra || ' ' || v_valor_total_movil);
END;