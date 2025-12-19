CREATE OR REPLACE PROCEDURE add_consumption(
    p_meter_id IN NUMBER,
    p_date IN DATE,
    p_volume IN NUMBER
)
AS
BEGIN
    -- Validate positive volume
    IF p_volume < 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Volume cannot be negative.');
    END IF;

    -- Insert water consumption
    INSERT INTO WATER_CONSUMPTION (CONSUMPTION_ID, METER_ID, CONSUMPTION_DATE, VOLUME)
    VALUES (WATER_CONSUMPTION_SEQ.NEXTVAL, p_meter_id, p_date, p_volume);

    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END;
/








CREATE OR REPLACE PROCEDURE update_meter_status(
    p_meter_id IN NUMBER,
    p_status IN VARCHAR2
)
AS
BEGIN
    -- Validate status
    IF p_status NOT IN ('ACTIVE', 'INACTIVE') THEN
        RAISE_APPLICATION_ERROR(-20002, 'Invalid meter status.');
    END IF;

    -- Update meter status
    UPDATE WATER_METERS
    SET STATUS = p_status
    WHERE METER_ID = p_meter_id;

    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END;
/











CREATE OR REPLACE PROCEDURE delete_consumption(
    p_consumption_id IN NUMBER
)
AS
BEGIN
    DELETE FROM WATER_CONSUMPTION
    WHERE CONSUMPTION_ID = p_consumption_id;

    COMMIT;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20003, 'Consumption record not found.');
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END;
/












CREATE OR REPLACE PROCEDURE add_meter(
    p_location_id IN NUMBER,
    p_sector_id IN NUMBER,
    p_status IN VARCHAR2
)
AS
BEGIN
    -- Validate status
    IF p_status NOT IN ('ACTIVE', 'INACTIVE') THEN
        RAISE_APPLICATION_ERROR(-20004, 'Invalid meter status.');
    END IF;

    -- Insert new meter
    INSERT INTO WATER_METERS (METER_ID, LOCATION_ID, SECTOR_ID, STATUS)
    VALUES (WATER_METERS_SEQ.NEXTVAL, p_location_id, p_sector_id, p_status);

    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END;
/






CREATE OR REPLACE PROCEDURE add_system_user(
    p_username IN VARCHAR2,
    p_password IN VARCHAR2,
    p_role IN VARCHAR2
)
AS
BEGIN
    -- Validate role
    IF p_role NOT IN ('ADMIN', 'EMPLOYEE') THEN
        RAISE_APPLICATION_ERROR(-20005, 'Invalid user role.');
    END IF;

    -- Insert user
    INSERT INTO SYSTEM_USERS (USER_ID, USERNAME, PASSWORD, ROLE)
    VALUES (SYSTEM_USERS_SEQ.NEXTVAL, p_username, p_password, p_role);

    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END;
/





