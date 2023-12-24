CREATE OR REPLACE TRIGGER dgr_consumos
    AFTER INSERT OR DELETE OR UPDATE ON consumo
    FOR EACH ROW
BEGIN
    IF inserting THEN
        UPDATE total_consumos SET monto_consumos = monto_consumos + :new.monto 
        WHERE id_huesped = :new.id_huesped;
    ELSIF deleting THEN
        UPDATE total_consumos SET monto_consumos = monto_consumos - :old.monto 
        WHERE id_huesped = :old.id_huesped;
    ELSIF updating THEN
        UPDATE total_consumos SET monto_consumos = monto_consumos + (:new.monto - :old.monto) 
        WHERE id_huesped = :old.id_huesped;
    END IF;
END;

INSERT INTO consumo VALUES (11527,1587,340039, 100);
DELETE FROM consumo WHERE id_consumo = 10417;
UPDATE consumo SET monto = 56 WHERE id_consumo = 10901;
UPDATE consumo SET monto = 80 WHERE id_consumo = 11214;
COMMIT;
select * from total_consumos where id_huesped between 340036 and 340043;