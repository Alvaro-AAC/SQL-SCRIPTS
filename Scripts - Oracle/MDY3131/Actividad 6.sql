DECLARE
    CURSOR c_morosos IS (
        SELECT 
            c.pac_run,
            dv_run,
            pnombre || ' ' || snombre || ' ' || apaterno || ' ' || amaterno pac_nombre,
            a.ate_id, 
            fecha_venc_pago, 
            fecha_pago,
            e.nombre especialidad_atencion,
            NVL(d.porcentaje_descto, 0) porc_descto
        FROM pago_atencion a
        JOIN atencion b 
            ON (a.ate_id = b.ate_id)
        JOIN paciente c 
            ON (b.pac_run = c.pac_run)
        LEFT JOIN porc_descto_3ra_edad d
            ON(TRUNC(MONTHS_BETWEEN(sysdate, c.fecha_nacimiento)/12) BETWEEN d.anno_ini AND d.anno_ter)
        JOIN especialidad e
            ON (b.esp_id = e.esp_id)
        WHERE fecha_pago>fecha_venc_pago AND EXTRACT(YEAR FROM fecha_venc_pago)=EXTRACT(YEAR FROM sysdate)-1
    );
    
    v_rec c_morosos%ROWTYPE;
    v_dias_morosos NUMBER(3);
    v_multa_especialidad NUMBER(5);
BEGIN
    EXECUTE IMMEDIATE ('TRUNCATE TABLE pago_moroso');
    OPEN c_morosos;
    FETCH c_morosos INTO v_rec;
    WHILE (c_morosos%FOUND) LOOP 
        FETCH c_morosos INTO v_rec;
        v_dias_morosos := v_rec.fecha_pago-v_rec.fecha_venc_pago;
        CASE LOWER(v_rec.especialidad_atencion)
            WHEN 'dermatología' THEN v_multa_especialidad := 1200;
            WHEN 'cirugía general' THEN v_multa_especialidad := 1200;
            WHEN 'ortopedia y traumatología' THEN v_multa_especialidad := 1300;
            WHEN 'inmunología' THEN v_multa_especialidad := 1700;
            WHEN 'otorrinolaringología' THEN v_multa_especialidad := 1700;
            WHEN 'fisiatría' THEN v_multa_especialidad := 1900;
            WHEN 'medicina interna' THEN v_multa_especialidad := 1900;
            WHEN 'medicina general' THEN v_multa_especialidad := 1100;
            WHEN 'psiquiatría adultos' THEN v_multa_especialidad := 2000;
            WHEN 'cirugía digestiva' THEN v_multa_especialidad := 2300;
            WHEN 'reumatología' THEN v_multa_especialidad := 2300;
            ELSE v_multa_especialidad:=0;
        END CASE;
        dbms_output.put_line(v_multa_especialidad);
    END LOOP;
END;

