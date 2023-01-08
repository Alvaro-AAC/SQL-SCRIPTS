DECLARE
    v_nombre VARCHAR2(100);
    v_min_codigo NUMBER(2);
    v_max_codigo NUMBER(2);
BEGIN
    SELECT 
        min(codigo), max(codigo) INTO v_min_codigo, v_max_codigo
    FROM producto;
    dbms_output.put_line('LISTA DE NOMBRE DE PRODUCTOS: ');
    FOR i IN v_min_codigo .. v_max_codigo LOOP
        SELECT nombre
            INTO v_nombre
        FROM producto
        WHERE codigo = i;
        dbms_output.put_line(v_nombre);
    END LOOP;
END;