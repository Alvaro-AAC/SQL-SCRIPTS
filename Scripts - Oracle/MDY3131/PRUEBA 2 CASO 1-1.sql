DECLARE
   -- cursor que recupera los viñateros o productores que tienen asignado un producto
   CURSOR c1 IS
   SELECT *
   FROM productor
   where id_productor in (select id_productor
                          from producto);
   -- cursor que recupera productos de cada viñatero
   -- recibe como parámetro la id del productor
   CURSOR c2 (n NUMBER) IS
   SELECT *
   FROM producto
   WHERE id_productor = n;
   counter number := 0;
   r1 productor%ROWTYPE;
   r2 producto%ROWTYPE;
BEGIN
   OPEN c1;
   LOOP
   FETCH c1 INTO r1;
      EXIT WHEN c1%NOTFOUND;
      dbms_output.put_line('####### LISTA DE VINOS DE LA VIÑA ' || '"' || UPPER(r1.nom_productor || '"'));
      dbms_output.put_line(CHR(13));   
      dbms_output.put_line(lpad('-',65,'-'));
      dbms_output.put_line('  ID  NOMBRE PRODUCTO      STOCK  PRECIO ACTUAL   NUEVO PRECIO');
      dbms_output.put_line(lpad('-',65,'-'));
      counter := 0;
      OPEN c2 (r1.id_productor);
      LOOP
         FETCH c2 INTO r2;
         EXIT WHEN c2%NOTFOUND;
         counter := counter + 1;       
             dbms_output.put_line(r2.id_producto
                || ' ' || RPAD(r2.nom_producto, 20,' ')
                || ' ' || TO_CHAR(r2.stock,'999')
                || ' ' || rpad(TO_CHAR(r2.precio, '$9G999G999'),15, ' ')
                || ' ' || TO_CHAR(r2.precio * 1.07, '$9G999G999'));
      END LOOP; 
      CLOSE c2;
      dbms_output.put_line(lpad('-',65,'-'));      
      dbms_output.put_line('Total de productos en tienda: ' || counter);      
      dbms_output.put_line(CHR(12));
   END LOOP;
   CLOSE c1;
 END;
