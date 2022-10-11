-- 5.1 Для однієї з таблиць, що містить обмеження цілісності зовнішнього ключа, виконати
-- команду зміни значення колонки зовнішнього ключа на значення, яке відсутнє в колонці
-- первинного ключа відповідної таблиці. Перевірити реакцію СКБД на таку зміну.

UPDATE Bill 
    SET packageId = '10'
    WHERE billId = '1'; 
/*
ERROR at line 1:
ORA-02291: integrity constraint (SYSTEM.BILL_PACKAGEID_FK) violated - parent
key not found
*/

-- 5.2 Повторити рішення завдання 5.1, але таке, що не призводить до порушення цілісності
-- зовнішнього ключа.
UPDATE Bill 
    SET packageId = '3'
    WHERE billId = '1'; 
-- 1 row updated.

-- 5.3 Для однієї з таблиць, що містить обмеження цілісності первинного ключа, пов'язане з
-- колонкою зовнішнього ключа іншої таблиці, виконати одну команду видалення рядка зі значенням
-- колонки первинного ключа, що є в колонці зовнішнього ключа іншої таблиці. Перевірити реакцію
-- СКБД видалення.
DELETE FROM InternetPackage 
WHERE packageId = '3'; 
/*
ERROR at line 1:
ORA-02292: integrity constraint (SYSTEM.BILL_PACKAGEID_FK) violated - child
record found
*/

-- 5.4 Повторити рішення завдання 5.3, але таке, що не призводить до порушення цілісності
-- зовнішнього ключа.
ALTER TABLE Bill
DROP CONSTRAINT bill_packageId_fk; 
DELETE FROM InternetPackage 
WHERE packageId = '3'; 
-- SQL> ALTER TABLE Bill
--   2  DROP CONSTRAINT bill_fk;
-- 
-- Table altered.
-- 
-- SQL> DELETE FROM InternetPackage
--   2  WHERE packageId = '3';
-- 
-- 1 row deleted.

-- 5.5 Для однієї з таблиць, що містить обмеження цілісності первинного ключа, виконати
-- команду зміни значення колонки первинного ключа на значення, яке відсутнє у колонці
-- зовнішнього ключа відповідної таблиці. Перевірити реакцію СКБД на таку зміну.
UPDATE Bill 
    SET packageId = '10'
    WHERE billId = '1'; 
/*
ERROR at line 1:
ORA-02291: integrity constraint (SYSTEM.BILL_PACKAGEID_FK) violated - parent
key not found
*/

-- 5.6 Повторити рішення завдання 5.5, але таке, що не призводить до порушення цілісності
-- зовнішнього ключа.
UPDATE Bill 
    SET packageId = '4'
    WHERE billId = '1'; 
-- 1 row updated.