SELECT 
    b.nom_cepa,
    COUNT(a.id_cepa),
    SUM(a.precio*c.cantidad)
FROM producto a
RIGHT OUTER JOIN cepa b
    ON (a.id_cepa = b.id_cepa)
JOIN detalle_pedido c
    ON (a.id_producto = c.id_producto)
JOIN pedido d
    ON (c.id_pedido = d.id_pedido)
WHERE NVL(fec_pedido, TO_DATE('02-06-2021','DD-MM-YYYY')) BETWEEN TO_DATE('01-06-2021','DD-MM-YYYY') AND TO_DATE('30-06-2021','DD-MM-YYYY')
GROUP BY (b.nom_cepa)
;
SELECT COUNT(b.id_cepa) FROM CEPA a LEFT JOIN producto b ON (a.id_cepa = b.id_cepa) GROUP BY (a.nom_cepa);

select * from cepa;