DECLARE
    CURSOR c_emp IS (
        SELECT * FROM empleado
    );
    v_row_emp empleado%ROWTYPE;
    TYPE r_emp IS RECORD(
        v_id_empleado empleado.id_empleado%TYPE,
        v_nombres empleado.nombres%TYPE,
        v_sueldo empleado.sueldo%TYPE,
        v_sueldo_aumentado empleado.sueldo%TYPE
    );
    v_data_emp r_emp;
BEGIN
    FOR cur_emp IN (SELECT id_empleado, nombres, sueldo FROM empleado) LOOP
        v_data_emp.v_id_empleado := cur_emp.id_empleado;
        v_data_emp.v_nombres := TRIM(cur_emp.nombres);
        v_data_emp.v_sueldo := cur_emp.sueldo;
        v_data_emp.v_sueldo_aumentado := ROUND(cur_emp.sueldo*115/100);
        dbms_output.put_line(v_data_emp.v_id_empleado || ' ' || v_data_emp.v_nombres
            || ' ' || v_data_emp.v_sueldo || ' ' || v_data_emp.v_sueldo_aumentado);
    END LOOP;

    OPEN c_emp;
    FETCH c_emp INTO v_row_emp;
    WHILE (c_emp%FOUND) LOOP
        dbms_output.put_line(v_row_emp.id_empleado);
        FETCH c_emp INTO v_row_emp;
    END LOOP;
    CLOSE c_emp;
END;