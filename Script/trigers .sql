CREATE OR REPLACE TRIGGER trg_block_dml
BEFORE INSERT OR UPDATE OR DELETE ON WATER_CONSUMPTION
BEGIN
    IF is_restricted_day THEN
        log_audit('DML', 'WATER_CONSUMPTION', 'DENIED',
                  'Operation blocked: restricted day');
        RAISE_APPLICATION_ERROR(-20001,
          'Operation not allowed on weekdays or holidays');
    ELSE
        log_audit('DML', 'WATER_CONSUMPTION', 'ALLOWED',
                  'Operation allowed');
    END IF;
END;
/





CREATE OR REPLACE TRIGGER trg_compound_audit
FOR INSERT OR UPDATE OR DELETE ON WATER_METERS
COMPOUND TRIGGER

BEFORE STATEMENT IS
BEGIN
    IF is_restricted_day THEN
        log_audit('DML', 'WATER_METERS', 'DENIED',
                  'Restricted day (statement)');
        RAISE_APPLICATION_ERROR(-20002,
          'DML not allowed today');
    END IF;
END BEFORE STATEMENT;

AFTER STATEMENT IS
BEGIN
    log_audit('DML', 'WATER_METERS', 'ALLOWED',
              'Statement executed successfully');
END AFTER STATEMENT;

END;
/









--- TESTING

INSERT INTO WATER_CONSUMPTION VALUES (1, 101, SYSDATE, 20);
-- DENIED


--- TESTING
-- Run on Saturday/Sunday
INSERT INTO WATER_CONSUMPTION VALUES (2, 101, SYSDATE, 15);
-- ALLOWED

--- 



INSERT INTO HOLIDAYS (HOLIDAY_DATE, DESCRIPTION)
VALUES (TRUNC(SYSDATE), 'Test Holiday');

INSERT INTO WATER_CONSUMPTION VALUES (3, 101, SYSDATE, 10);
-- DENIED


SELECT * FROM AUDIT_LOG;

