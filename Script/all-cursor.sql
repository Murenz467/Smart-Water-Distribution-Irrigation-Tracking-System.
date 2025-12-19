DECLARE
    CURSOR meter_cursor IS
        SELECT METER_ID, METER_STATUS
        FROM WATER_METERS
        WHERE SECTOR_ID = 101;  -- replace with your sector ID

    v_meter_id WATER_METERS.METER_ID%TYPE;
    v_status   WATER_METERS.METER_STATUS%TYPE;
BEGIN
    OPEN meter_cursor;
    LOOP
        FETCH meter_cursor INTO v_meter_id, v_status;
        EXIT WHEN meter_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Meter ID: ' || v_meter_id || ', Status: ' || v_status);
    END LOOP;
    CLOSE meter_cursor;
END;
/



DECLARE
    TYPE consumption_tbl IS TABLE OF WATER_CONSUMPTION.VOLUME%TYPE;
    v_volumes consumption_tbl;

BEGIN
    SELECT VOLUME BULK COLLECT INTO v_volumes
    FROM WATER_CONSUMPTION
    WHERE CONSUMPTION_DATE >= SYSDATE - 30; -- last 30 days

    FOR i IN 1 .. v_volumes.COUNT LOOP
        DBMS_OUTPUT.PUT_LINE('Volume: ' || v_volumes(i));
    END LOOP;
END;
/


