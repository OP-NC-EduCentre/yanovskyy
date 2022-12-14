CREATE OR REPLACE VIEW ATTRTYPE_LIST
(OBJECT_CODE, ATTR_ID, ATTR_CODE, NAME)
AS
SELECT
    OBJTYPE.CODE AS O_CODE,
    ATTRTYPE.ATTR_ID AS ATTR,
    ATTRTYPE.CODE AS A_CODE,
    ATTRTYPE.NAME AS A_NAME
FROM OBJTYPE, ATTRTYPE
WHERE
    OBJTYPE.OBJECT_TYPE_ID = ATTRTYPE.OBJECT_TYPE_ID
ORDER BY
    ATTRTYPE.OBJECT_TYPE_ID,
    ATTRTYPE.ATTR_ID;
SELECT
    O_CODE,
    ATTR,
    A_CODE,
    A_NAME
FROM ATTRTYPE_LIST;

UPDATE ATTRTYPE_LIST
SET ATTR_CODE = 'NEW ATTR CODE'
WHERE ATTR_ID = '12';

CREATE OR REPLACE VIEW OBJECTS_COUNTS
AS
SELECT
    DESCRIPTION AS CLAS_S,
    COUNT(DESCRIPTION) AS COUNT_DESCR
FROM OBJECTS GROUP BY DESCRIPTION;

SELECT
    CLAS_S,
    COUNT_DESCR
FROM OBJECTS_COUNTS;

UPDATE ATTRTYPE_COUNTS
SET ATTR_ID_C = '-1'
WHERE OBJCODE_C = '13';
