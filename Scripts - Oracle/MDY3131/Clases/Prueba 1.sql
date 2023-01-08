VAR vb_porce_1 NUMBER; -- 15
VAR vb_porce_2 NUMBER; -- 20
VAR vb_porce_3 NUMBER; -- 25
VAR vb_porce_4 NUMBER; -- 30
VAR vb_porce_5 NUMBER; -- 35
VAR vb_fecha_ejecucion VARCHAR2; -- 2021-06
/*
EXEC :vb_fecha_ejecucion := '2021-06';
EXEC :vb_porce_1 := 15;
EXEC :vb_porce_2 := 20;
EXEC :vb_porce_3 := 25;
EXEC :vb_porce_4 := 30;
EXEC :vb_porce_5 := 35;
*/
DECLARE
	v_anno DETALLE_VENTA_EMPLEADO.anno%TYPE;
	v_mes DETALLE_VENTA_EMPLEADO.mes%TYPE;
	v_nombre DETALLE_VENTA_EMPLEADO.nombre%TYPE;
	v_equipo_emp DETALLE_VENTA_EMPLEADO.equipo_emp%TYPE;
	v_nro_ventas DETALLE_VENTA_EMPLEADO.nro_ventas%TYPE;
	v_ventas_netas_mes DETALLE_VENTA_EMPLEADO.ventas_netas_mes%TYPE;
	v_bono_equipo DETALLE_VENTA_EMPLEADO.bono_equipo%TYPE;
	v_incentivo_categorizacion DETALLE_VENTA_EMPLEADO.incentivo_categorizacion%TYPE;
	v_asignacion_vtas DETALLE_VENTA_EMPLEADO.asignacion_vtas%TYPE;
	v_asignacion_antig DETALLE_VENTA_EMPLEADO.asignacion_antig%TYPE;
	v_descuentos DETALLE_VENTA_EMPLEADO.descuentos%TYPE;
	v_totales_mes DETALLE_VENTA_EMPLEADO.totales_mes%TYPE;
    v_id_iterator EMPLEADO.id_empleado%TYPE;
    v_id_max EMPLEADO.id_empleado%TYPE;
    v_porc_bono_equipo EQUIPO.porc%TYPE;
    v_porc_bono_cat CATEGORIZACION.porcentaje%TYPE;
    v_annos_antig NUMBER;
	v_comision COMISION_VENTA_EMPLEADO.monto_comision%TYPE;
BEGIN
    --Truncar tablas
    EXECUTE IMMEDIATE ('TRUNCATE TABLE detalle_venta_empleado');
    EXECUTE IMMEDIATE ('TRUNCATE TABLE comision_venta_empleado');
    
    --Establecer el año y el mes dada la fecha  
    v_anno := SUBSTR(:vb_fecha_ejecucion, 1, 4);
    v_mes := SUBSTR(:vb_fecha_ejecucion, 6);
    v_descuentos := 0;
    
    --Almacenar la ID minima y maxima
    SELECT MIN(id_empleado), MAX(id_empleado) INTO v_id_iterator, v_id_max FROM empleado;
    
    --Bucle que itera sobre todas las filas de la tabla EMPLEADO, recorriendo las IDs
    WHILE v_id_iterator <= v_id_max LOOP
        -- Consulta a empleado para establecer el nombre, equipo, los porcentajes de bono por equipo y categorizacion y años de antigüedad
        SELECT 
            TRIM(apellidos) || ' ' || TRIM(nombres),
            NVL(nom_equipo, 'No aplica'),
            NVL(b.porc, 0),
            NVL(c.porcentaje, 0),
            TRUNC(MONTHS_BETWEEN(sysdate, a.feccontrato)/12)
        INTO v_nombre, v_equipo_emp, v_porc_bono_equipo, v_porc_bono_cat, v_annos_antig
        FROM empleado a
        LEFT JOIN equipo b ON (a.id_equipo = b.id_equipo)
        LEFT JOIN categorizacion c ON (a.id_categorizacion = c.id_categorizacion)
        WHERE id_empleado = v_id_iterator;
        
        -- Consulta para establecer la cantidad de ventas y el valor neto de sus ventas en el mes correspondiente
        SELECT
            COUNT(a.id_boleta),
            SUM(cantidad*precio)
        INTO v_nro_ventas, v_ventas_netas_mes
        FROM boleta a
        JOIN detalleboleta b ON (a.id_boleta = b.id_boleta)
        JOIN producto c ON (b.id_producto = c.id_producto)
        WHERE 
            a.id_empleado = v_id_iterator AND
            (EXTRACT(YEAR FROM a.fecha_boleta) = v_anno AND
             EXTRACT(MONTH FROM a.fecha_boleta) = v_mes)
        GROUP BY (a.id_empleado);
        
        --Establecer los valores de bono y equipo segun los porcentajes obtenidos anteriormente
        v_bono_equipo := ROUND((v_porc_bono_equipo/100)*v_ventas_netas_mes);
        v_incentivo_categorizacion := ROUND((v_porc_bono_cat/100)*v_ventas_netas_mes);
        
        --CASE (switch) para determinar el bono de asignacion por ventas, parametrizando los porcentajes con variables BIND
        CASE
            WHEN v_nro_ventas BETWEEN 1 AND 2 
                THEN v_asignacion_vtas := ROUND((:vb_porce_1/100)*v_ventas_netas_mes);
            WHEN v_nro_ventas BETWEEN 3 AND 5 
                THEN v_asignacion_vtas := ROUND((:vb_porce_2/100)*v_ventas_netas_mes);
            WHEN v_nro_ventas BETWEEN 6 AND 8 
                THEN v_asignacion_vtas := ROUND((:vb_porce_3/100)*v_ventas_netas_mes);
            WHEN v_nro_ventas BETWEEN 9 AND 10 
                THEN v_asignacion_vtas := ROUND((:vb_porce_4/100)*v_ventas_netas_mes);
            WHEN v_nro_ventas BETWEEN 11 AND 99 
                THEN v_asignacion_vtas := ROUND((:vb_porce_5/100)*v_ventas_netas_mes);
            ELSE v_asignacion_vtas := 0;
        END CASE;
        
        --CASE (switch) para calcular el bono de asignacion por antigüedad según los años obtenidos anteriormente
        CASE
            WHEN v_annos_antig BETWEEN 3 AND 7
                THEN v_asignacion_antig := ROUND(v_ventas_netas_mes*0.04);
            WHEN v_annos_antig BETWEEN 8 AND 15
                THEN v_asignacion_antig := ROUND(v_ventas_netas_mes*0.14);
            WHEN v_annos_antig > 15
                THEN v_asignacion_antig := ROUND(v_ventas_netas_mes*0.27);
            ELSE v_asignacion_antig := 0;
        END CASE;
        
        --Suma de valores para obtener el total
        v_totales_mes := v_ventas_netas_mes + v_bono_equipo + 
            v_incentivo_categorizacion + v_asignacion_vtas + v_asignacion_antig + v_descuentos;
            
        --CASE (switch) para calcular la comision
        CASE
            WHEN v_totales_mes BETWEEN 0 AND 100000
                THEN v_comision := 0;
            WHEN v_totales_mes BETWEEN 100001 AND 200000       
                THEN v_comision := ROUND(v_totales_mes*0.024);
            WHEN v_totales_mes BETWEEN 200001 AND 300000       
                THEN v_comision := ROUND(v_totales_mes*0.036);
            WHEN v_totales_mes BETWEEN 300001 AND 400000       
                THEN v_comision := ROUND(v_totales_mes*0.044);
            WHEN v_totales_mes BETWEEN 400001 AND 900000       
                THEN v_comision := ROUND(v_totales_mes*0.056);
            WHEN v_totales_mes BETWEEN 900001 AND 1400000      
                THEN v_comision := ROUND(v_totales_mes*0.053);
            WHEN v_totales_mes BETWEEN 1400001 AND 2500000     
                THEN v_comision := ROUND(v_totales_mes*0.044);
            WHEN v_totales_mes BETWEEN 2500001 AND 6000000     
                THEN v_comision := ROUND(v_totales_mes*0.038);
            ELSE v_comision := 0;
        END CASE;

        --Insertar los valores obtenidos en la tabla determinada
        INSERT INTO DETALLE_VENTA_EMPLEADO VALUES (v_anno, v_mes, v_id_iterator, 
            v_nombre, v_equipo_emp, v_nro_ventas, v_ventas_netas_mes, v_bono_equipo, 
            v_incentivo_categorizacion, v_asignacion_vtas, v_asignacion_antig, 
            v_descuentos, v_totales_mes);
        INSERT INTO COMISION_VENTA_EMPLEADO VALUES (v_anno, v_mes, 
            v_id_iterator, v_totales_mes, v_comision);
        
        --Aumentar el valor del iterador en 2 para que continue al siguiente empleado
        v_id_iterator := v_id_iterator+2;
    END LOOP;
COMMIT;
END;