CREATE OR REPLACE PACKAGE pk_ejemplo IS
    vp_nom_depto departments.department_name%TYPE;
    vp_cargo jobs.job_title%TYPE;
    FUNCTION fn_busca_nom_depto (p_id_depto NUMBER) RETURN VARCHAR2;
    PROCEDURE proc_ejemplo (p_id_cargo VARCHAR2);
END;

CREATE OR REPLACE PACKAGE BODY pk_ejemplo IS
    FUNCTION fn_busca_nom_depto (p_id_depto NUMBER) RETURN VARCHAR2 IS
        v_nom_depto departments.department_name%TYPE;
    BEGIN
        SELECT departments.department_name
        INTO v_nom_depto
        FROM departments
        WHERE departments.department_id = p_id_depto;
        RETURN v_nom_depto;
    EXCEPTION
        WHEN no_data_found THEN
        RETURN 'No se encontro departamento';
    END fn_busca_nom_depto;
    
    PROCEDURE proc_ejemplo (p_id_cargo VARCHAR2) IS
        CURSOR cur_emp IS
            SELECT first_name, salary, department_id
            FROM employees WHERE job_id = p_id_cargo;
        BEGIN
            FOR v_reg IN cur_emp LOOP
                vp_nom_depto := fn_busca_nom_depto(v_reg.department_id);
                BEGIN
                    SELECT job_title INTO vp_cargo
                    FROM jobs WHERE job_id = p_id_cargo;
                EXCEPTION
                    WHEN no_data_found THEN
                        vp_cargo := 'No se encuentra registro jobs';
                END;
                dbms_output.put_line(v_reg.first_name || ' ' || v_reg.salary ||
                                    ' ' || v_reg.department_id || ' ' ||
                                    vp_nom_depto || ' ' || vp_cargo);
            END LOOP;
        END proc_ejemplo;
END pk_ejemplo;