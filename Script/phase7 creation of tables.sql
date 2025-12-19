CREATE TABLE HOLIDAYS (
    HOLIDAY_ID   NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    HOLIDAY_DATE DATE NOT NULL,
    DESCRIPTION  VARCHAR2(100)
);



CREATE TABLE AUDIT_LOG (
    AUDIT_ID      NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    USERNAME      VARCHAR2(30),
    ACTION_TYPE   VARCHAR2(10),
    TABLE_NAME    VARCHAR2(30),
    ACTION_DATE   DATE DEFAULT SYSDATE,
    STATUS        VARCHAR2(10),
    MESSAGE       VARCHAR2(200)
);







CREATE OR REPLACE PROCEDURE log_audit (
    p_action   IN VARCHAR2,
    p_table    IN VARCHAR2,
    p_status   IN VARCHAR2,
    p_message  IN VARCHAR2
) IS
BEGIN
    INSERT INTO AUDIT_LOG (USERNAME, ACTION_TYPE, TABLE_NAME, STATUS, MESSAGE)
    VALUES (USER, p_action, p_table, p_status, p_message);
END;
/







CREATE OR REPLACE FUNCTION is_restricted_day
RETURN BOOLEAN IS
    v_day     VARCHAR2(10);
    v_count   NUMBER;
BEGIN
    -- Check weekday
    v_day := TO_CHAR(SYSDATE, 'DY', 'NLS_DATE_LANGUAGE=ENGLISH');

    IF v_day IN ('MON','TUE','WED','THU','FRI') THEN
        RETURN TRUE;
    END IF;

    -- Check holiday
    SELECT COUNT(*) INTO v_count
    FROM HOLIDAYS
    WHERE HOLIDAY_DATE = TRUNC(SYSDATE);

    IF v_count > 0 THEN
        RETURN TRUE;
    END IF;

    RETURN FALSE;
END;
/


