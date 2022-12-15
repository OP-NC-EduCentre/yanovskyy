SELECT
    ATTR_ID,
    OBJECT_TYPE_ID,
    OBJECT_TYPE_ID_REF,
    CODE,
    NAME
FROM ATTRTYPE
WHERE CODE = 'clientId';

SELECT COUNT(ATTR_ID) AS COUNT_IDS
FROM ATTRTYPE;

SELECT
    ATTRTYPE.CODE,
    OBJTYPE.OBJECT_TYPE_ID,
    OBJTYPE.NAME
FROM OBJTYPE LEFT JOIN ATTRTYPE
    ON ATTRTYPE.OBJECT_TYPE_ID_REF = OBJTYPE.OBJECT_TYPE_ID;
