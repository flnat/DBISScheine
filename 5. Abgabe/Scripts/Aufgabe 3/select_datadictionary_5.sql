SELECT
    uc.CONSTRAINT_NAME, uc.CONSTRAINT_TYPE,
    cc.COLUMN_NAME, cc.POSITION, uc.SEARCH_CONDITION,
    uc.DEFERRED, uc.DEFERRABLE, uc.STATUS
    
FROM USER_CONSTRAINTS uc, USER_CONS_COLUMNS cc
WHERE
    uc.CONSTRAINT_NAME = cc.CONSTRAINT_NAME AND
    uc.TABLE_NAME = '&TableName' AND
    uc.CONSTRAINT_TYPE IN ('P', 'U', 'C')
;