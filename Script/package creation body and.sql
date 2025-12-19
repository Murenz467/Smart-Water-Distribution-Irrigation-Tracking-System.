
CREATE OR REPLACE PACKAGE switracker_pkg IS

  -- Custom Exceptions
  e_invalid_meter EXCEPTION;
  e_invalid_sector EXCEPTION;

  -- Error logging
  PROCEDURE log_error(
    p_module   IN VARCHAR2,
    p_message  IN VARCHAR2
  );

  -- Functions
  FUNCTION get_total_consumption(p_meter_id IN NUMBER) RETURN NUMBER;
  FUNCTION get_average_consumption(p_sector_id IN NUMBER) RETURN NUMBER;
  FUNCTION get_max_consumption(p_sector_id IN NUMBER) RETURN NUMBER;
  FUNCTION is_valid_meter(p_meter_id IN NUMBER) RETURN VARCHAR2;

  -- Procedures
  PROCEDURE show_meter_rank(p_sector_id IN NUMBER);
  PROCEDURE show_monthly_comparison(p_meter_id IN NUMBER);

END switracker_pkg;
/



















CREATE OR REPLACE PACKAGE BODY switracker_pkg IS

  -- =============================
  -- Error logging procedure
  -- =============================
  PROCEDURE log_error(
    p_module   IN VARCHAR2,
    p_message  IN VARCHAR2
  ) IS
  BEGIN
    INSERT INTO AUDIT_LOG(log_date, module_name, message)
    VALUES (SYSDATE, p_module, p_message);
    COMMIT;
  END log_error;

  -- =============================
  -- Total Consumption
  -- =============================
  FUNCTION get_total_consumption(p_meter_id IN NUMBER) RETURN NUMBER IS
    v_total NUMBER;
    v_count NUMBER;
  BEGIN
    SELECT COUNT(*) INTO v_count
    FROM WATER_METERS
    WHERE METER_ID = p_meter_id;

    IF v_count = 0 THEN
      RAISE e_invalid_meter;
    END IF;

    SELECT NVL(SUM(VOLUME),0)
    INTO v_total
    FROM WATER_CONSUMPTION
    WHERE METER_ID = p_meter_id;

    RETURN v_total;

  EXCEPTION
    WHEN e_invalid_meter THEN
      log_error('get_total_consumption','Invalid meter ID');
      RETURN 0;

    WHEN OTHERS THEN
      log_error('get_total_consumption', SQLERRM);
      RETURN 0;
  END;

  -- =============================
  -- Average Consumption
  -- =============================
  FUNCTION get_average_consumption(p_sector_id IN NUMBER) RETURN NUMBER IS
    v_avg NUMBER;
  BEGIN
    SELECT NVL(AVG(wc.VOLUME),0)
    INTO v_avg
    FROM WATER_CONSUMPTION wc
    JOIN WATER_METERS wm ON wc.METER_ID = wm.METER_ID
    WHERE wm.SECTOR_ID = p_sector_id;

    RETURN v_avg;

  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      log_error('get_average_consumption','No data found');
      RETURN 0;

    WHEN OTHERS THEN
      log_error('get_average_consumption', SQLERRM);
      RETURN 0;
  END;

  -- =============================
  -- Max Consumption
  -- =============================
  FUNCTION get_max_consumption(p_sector_id IN NUMBER) RETURN NUMBER IS
    v_max NUMBER;
  BEGIN
    SELECT NVL(MAX(wc.VOLUME),0)
    INTO v_max
    FROM WATER_CONSUMPTION wc
    JOIN WATER_METERS wm ON wc.METER_ID = wm.METER_ID
    WHERE wm.SECTOR_ID = p_sector_id;

    RETURN v_max;

  EXCEPTION
    WHEN OTHERS THEN
      log_error('get_max_consumption', SQLERRM);
      RETURN 0;
  END;

  -- =============================
  -- Meter Validation
  -- =============================
  FUNCTION is_valid_meter(p_meter_id IN NUMBER) RETURN VARCHAR2 IS
    v_status VARCHAR2(20);
  BEGIN
    SELECT METER_STATUS
    INTO v_status
    FROM WATER_METERS
    WHERE METER_ID = p_meter_id;

    RETURN v_status;

  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      log_error('is_valid_meter','Meter not found');
      RETURN 'INVALID';

    WHEN OTHERS THEN
      log_error('is_valid_meter', SQLERRM);
      RETURN 'ERROR';
  END;

  -- =============================
  -- Rank meters (Window Function)
  -- =============================
  PROCEDURE show_meter_rank(p_sector_id IN NUMBER) IS
  BEGIN
    FOR rec IN (
      SELECT wm.METER_ID,
             SUM(wc.VOLUME) AS TOTAL_VOLUME,
             RANK() OVER (PARTITION BY wm.SECTOR_ID ORDER BY SUM(wc.VOLUME) DESC) AS RANK_IN_SECTOR
      FROM WATER_METERS wm
      JOIN WATER_CONSUMPTION wc ON wm.METER_ID = wc.METER_ID
      WHERE wm.SECTOR_ID = p_sector_id
      GROUP BY wm.METER_ID, wm.SECTOR_ID
    ) LOOP
      DBMS_OUTPUT.PUT_LINE(
        'Meter '||rec.METER_ID||' Rank '||rec.RANK_IN_SECTOR
      );
    END LOOP;

  EXCEPTION
    WHEN OTHERS THEN
      log_error('show_meter_rank', SQLERRM);
  END;

  -- =============================
  -- Monthly comparison (LAG)
  -- =============================
  PROCEDURE show_monthly_comparison(p_meter_id IN NUMBER) IS
  BEGIN
    FOR rec IN (
      SELECT TO_CHAR(CONSUMPTION_DATE,'YYYY-MM') AS MONTH,
             SUM(VOLUME) AS MONTH_VOLUME,
             LAG(SUM(VOLUME)) OVER (ORDER BY TO_CHAR(CONSUMPTION_DATE,'YYYY-MM')) AS PREVIOUS_MONTH
      FROM WATER_CONSUMPTION
      WHERE METER_ID = p_meter_id
      GROUP BY TO_CHAR(CONSUMPTION_DATE,'YYYY-MM')
    ) LOOP
      DBMS_OUTPUT.PUT_LINE(
        rec.MONTH||' Current='||rec.MONTH_VOLUME||
        ' Previous='||NVL(rec.PREVIOUS_MONTH,0)
      );
    END LOOP;

  EXCEPTION
    WHEN OTHERS THEN
      log_error('show_monthly_comparison', SQLERRM);
  END;

END switracker_pkg;
/

