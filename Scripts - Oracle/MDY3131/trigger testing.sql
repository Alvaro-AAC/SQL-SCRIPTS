CREATE OR REPLACE TRIGGER dgr_1 
    AFTER INSERT OR DELETE OR UPDATE ON detalle_boleta
    FOR EACH ROW
BEGIN
    IF inserting THEN
        UPDATE stock SET stock_actual = stock_actual - :new.cantidad 
        WHERE cod_producto = :new.cod_producto;
    ELSIF deleting THEN
        UPDATE stock SET stock_actual = stock_actual + :old.cantidad 
        WHERE cod_producto = :old.cod_producto;
    ELSIF updating THEN
        UPDATE stock SET stock_actual = stock_actual + (:old.cantidad - :new.cantidad) 
        WHERE cod_producto = :old.cod_producto;
    END IF;
END;

INSERT INTO boleta VALUES(105, '07/06/2022', 2500000, 22222222);
INSERT INTO detalle_boleta VALUES(105, 2000, 100, 1500, 150000);

UPDATE detalle_boleta SET cantidad=150 WHERE nro_boleta=105 and cod_producto = 2000;

DELETE FROM detalle_boleta WHERE nro_boleta=105 AND cod_producto = 2000;