DECLARE
	v_anno_tributario INFO_SII.anno_tributario%TYPE;
	v_id_emp INFO_SII.id_emp%TYPE;
	v_run_empleado INFO_SII.run_empleado%TYPE;
	v_nombre_empleado INFO_SII.nombre_empleado%TYPE;
	v_cargo INFO_SII.cargo%TYPE;
	v_meses_trabajados INFO_SII.meses_trabajados%TYPE;
	v_annos_trabajados INFO_SII.annos_trabajados%TYPE;
	v_sueldo_base_mensual INFO_SII.sueldo_base_mensual%TYPE;
    v_sueldo_base_real INFO_SII.sueldo_base_mensual%TYPE;
	v_sueldo_base_anual INFO_SII.sueldo_base_anual%TYPE;
	v_bono_annos_anual INFO_SII.bono_annos_anual%TYPE;
	v_bono_especial_anual INFO_SII.bono_especial_anual%TYPE;
	v_movilizacion_anual INFO_SII.movilizacion_anual%TYPE;
	v_colacion_anual INFO_SII.colacion_anual%TYPE;
	v_desctos_legales INFO_SII.desctos_legales%TYPE;
	v_sueldo_bruto_anual INFO_SII.sueldo_bruto_anual%TYPE;
	v_renta_imponible_anual INFO_SII.renta_imponible_anual%TYPE;
    v_min_id INFO_SII.id_emp%TYPE;
    v_max_id INFO_SII.id_emp%TYPE;
    v_iterator INFO_SII.id_emp%TYPE;
    v_cantidad_camiones NUMBER(3);
    v_cantidad_camiones_arrendados NUMBER(3);
    v_crypt1 NUMBER := 1;
    v_crypt2 NUMBER := 10;
    v_crypt3 NUMBER := 900;
    v_test1 varchar2(30);
BEGIN
    EXECUTE IMMEDIATE ('truncate table INFO_SII');
    SELECT EXTRACT(YEAR FROM sysdate) INTO v_anno_tributario FROM dual;
    SELECT MIN(id_emp), MAX(id_emp) INTO v_min_id, v_max_id FROM empleado;
    v_iterator := v_min_id;
    WHILE v_iterator <= v_max_id LOOP
        SELECT
            id_emp, 
            TO_CHAR(v_crypt1, '09')  || ' ' || TO_CHAR(numrun_emp, '99,999,999') || '-' || dvrun_emp || v_crypt2,
            UPPER(pnombre_emp || ' ' || NVL(snombre_emp, '') || ' ' || appaterno_emp || ' ' || NVL(apmaterno_emp, '')),
            CASE 
                WHEN TRUNC(MONTHS_BETWEEN(TO_DATE('01-01-' || (v_anno_tributario), 'MM-DD-YYYY'), fecha_contrato)) > 12 THEN 12
                ELSE TRUNC(MONTHS_BETWEEN(TO_DATE('01-01-' || (v_anno_tributario), 'MM-DD-YYYY'), fecha_contrato))
            END,
            TRUNC(TRUNC(MONTHS_BETWEEN(TO_DATE('01-01-' || (v_anno_tributario), 'MM-DD-YYYY'), fecha_contrato))/12),
            (sueldo_base || v_crypt3),
            sueldo_base,
            ((NVL(porcentaje, 0)/100) * sueldo_base)*12,
            ROUND((sueldo_base*20)/100)
        INTO
            v_id_emp,
            v_run_empleado,
            v_nombre_empleado,
            v_meses_trabajados,
            v_annos_trabajados,
            v_sueldo_base_mensual,
            v_sueldo_base_real,
            v_bono_annos_anual,
            v_colacion_anual
        FROM empleado a
        LEFT OUTER JOIN tramo_antiguedad b 
            ON ((EXTRACT(YEAR FROM sysdate)-1-EXTRACT(YEAR FROM fecha_contrato) BETWEEN tramo_inf AND tramo_sup) 
                AND anno_vig = (v_anno_tributario-1))
        WHERE id_emp = v_iterator;
        
        SELECT
            CASE 
                WHEN b.id_emp = a.id_emp THEN 'Encargado de arriendos'
                ELSE 'Labores administrativas'
            END
        INTO v_cargo
        FROM empleado a
        LEFT OUTER JOIN camion b ON (a.id_emp = b.id_emp)
        WHERE a.id_emp = v_iterator
        GROUP BY (b.id_emp, a.id_emp);
        
        SELECT COUNT(*)
        INTO v_cantidad_camiones
        FROM camion
        WHERE id_emp = v_iterator;
        
        v_sueldo_base_anual := v_sueldo_base_real * v_meses_trabajados;
        
        CASE LOWER(v_cargo)
            WHEN 'labores administrativas' 
                THEN v_bono_especial_anual := ((12*v_sueldo_base_real)/100)*v_meses_trabajados;
            WHEN 'encargado de arriendos' 
                THEN v_bono_especial_anual := (((v_cantidad_camiones * 5)/100)*v_sueldo_base_real)*v_meses_trabajados;
            ELSE v_bono_especial_anual := 0;
        END CASE;
        
        v_colacion_anual := v_colacion_anual * v_meses_trabajados;
        
        dbms_output.put_line(v_id_emp || ' ' || v_colacion_anual);
        v_crypt1 := v_crypt1 + 1;
        v_crypt2 := v_crypt2 + 3;
        v_crypt3 := v_crypt3 - 10;
        v_iterator := v_iterator + 10;
    END LOOP;
END;

--INSERT INTO INFO_SII VALUES ( v_anno_tributario, v_id_emp, v_run_empleado, v_nombre_empleado, v_cargo, v_meses_trabajados, v_annos_trabajados, v_sueldo_base_mensual, v_sueldo_base_anual, v_bono_annos_anual, v_bono_especial_anual, v_movilizacion_anual, v_colacion_anual, v_desctos_legales, v_sueldo_bruto_anual, v_renta_imponible_anual);