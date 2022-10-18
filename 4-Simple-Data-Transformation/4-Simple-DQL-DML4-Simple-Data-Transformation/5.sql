/*
5.1 Для однієї з таблиць створити команду отримання кількості рядків таблиці, згрупованих по
одній з колонок, яка також повинна бути отримана, об'єднавши її з командою отримання загальної
кількості рядків із зазначенням слова «Разом:», наприклад:
Колонка
Кількість
значення1
10
значення2
15
Разом:
25
При виконанні завдання необхідно врахувати, що підсумковий рядок завжди повинен бути
останнім, незалежно від значень колонки у попередніх рядках.
*/
SELECT PACKAGEID AS VALUE_PKGID, COUNT(*) AS COUNTS FROM BILL GROUP BY PACKAGEID
UNION
SELECT 'total' AS VALUE, SUM(COUNT) as TOTAL FROM (SELECT COUNT FROM (SELECT PACKAGEID, COUNT(*) as COUNT FROM BILL GROUP BY PACKAGEID));

/*
VALUE_PKGI     COUNTS
---------- ----------
4                   2
2                   3
1                   3
total               8
*/