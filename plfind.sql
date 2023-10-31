set SERVEROUTPUT ON SIZE 1000000;
set verify OFF;
  ACCEPT IDXXXX PROMPT 'Enter the value of IDXXXX : ';
set head off;
PROMPT Processing...;
DECLARE
  CURSOR UTC_cursor IS
    select TABLE_NAME, COLUMN_NAME 
    from USER_TAB_COLUMNS
    where COLUMN_NAME like 'ID%'
    and DATA_TYPE='NUMBER'
	and TABLE_NAME not like 'BIN$%';
  UTC_record UTC_cursor%ROWTYPE;

BEGIN
  FOR UTC_record IN UTC_cursor LOOP
    --FETCH UTC_cursor INTO UTC_record;
    --DBMS_OUTPUT.PUT_LINE('---');
    DECLARE
      v_count integer;
    BEGIN
      EXECUTE IMMEDIATE
            'select count(*) from '||
            UTC_record.TABLE_NAME||
            ' where '||
            UTC_record.COLUMN_NAME||
            ' = '||
            &&IDXXXX 
            INTO v_count;
      IF v_count>0 THEN
        DBMS_OUTPUT.PUT_LINE(v_count||' match(es) found in '||
                             UTC_record.TABLE_NAME||
                             ' / '||
                             UTC_record.COLUMN_NAME);
      END IF;
    END;	
  END LOOP;
  DBMS_OUTPUT.PUT_LINE('Done!');
END;
/
