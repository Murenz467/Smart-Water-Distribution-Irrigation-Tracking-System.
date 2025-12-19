CREATE OR REPLACE FUNCTION get_total_consumption(p_meter_id IN NUMBER)
RETURN NUMBER
AS
    v_total NUMBER;
BEGIN
    SELECT NVL(SUM(VOLUME), 0)
    INTO v_total
    FROM WATER_CONSUMPTION
    WHERE METER_ID = p_meter_id;

    RETURN v_total;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 0;
    WHEN OTHERS THEN
        RAISE;
END;
/








CREATE OR REPLACE FUNCTION get_average_consumption(p_sector_id IN NUMBER)
RETURN NUMBER
AS
    v_avg NUMBER;
BEGIN
    SELECT NVL(AVG(wc.VOLUME), 0)
    INTO v_avg
    FROM WATER_CONSUMPTION wc
    JOIN WATER_METERS wm ON wc.METER_ID = wm.METER_ID
    WHERE wm.SECTOR_ID = p_sector_id;

    RETURN v_avg;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 0;
    WHEN OTHERS THEN
        RAISE;
END;
/



























CREATE OR REPLACE FUNCTION get_average_consumption(p_sector_id IN NUMBER)
RETURN NUMBER
AS
    v_avg NUMBER;
BEGIN
    SELECT NVL(AVG(wc.VOLUME), 0)
    INTO v_avg
    FROM WATER_CONSUMPTION wc
    JOIN WATER_METERS wm ON wc.METER_ID = wm.METER_ID
    WHERE wm.SECTOR_ID = p_sector_id;

    RETURN v_avg;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 0;
    WHEN OTHERS THEN
        RAISE;
END;
/









CREATE OR REPLACE FUNCTION is_valid_meter(p_meter_id IN NUMBER)
RETURN VARCHAR2
AS
    v_status VARCHAR2(10);
BEGIN
    SELECT STATUS
    INTO v_status
    FROM WATER_METERS
    WHERE METER_ID = p_meter_id;

    RETURN v_status;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 'INVALID';
    WHEN OTHERS THEN
        RAISE;
END;
/










CREATE OR REPLACE FUNCTION get_user_role(p_username IN VARCHAR2)
RETURN VARCHAR2
AS
    v_role VARCHAR2(20);
BEGIN
    SELECT ROLE
    INTO v_role
    FROM SYSTEM_USERS
    WHERE USERNAME = p_username;

    RETURN v_role;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 'UNKNOWN';
    WHEN OTHERS THEN
        RAISE;
END;
/






CREATE OR REPLACE FUNCTION get_max_consumption(p_sector_id IN NUMBER)
RETURN NUMBER
AS
    v_max NUMBER;
BEGIN
    SELECT NVL(MAX(wc.VOLUME), 0)
    INTO v_max
    FROM WATER_CONSUMPTION wc
    JOIN WATER_METERS wm ON wc.METER_ID = wm.METER_ID
    WHERE wm.SECTOR_ID = p_sector_id;

    RETURN v_max;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 0;
    WHEN OTHERS THEN
        RAISE;
END;
/













DESC WATER_METERS;
DESC WATER_CONSUMPTION;

