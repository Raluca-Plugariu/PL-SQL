drop table S_USERS;
/
Create table s_users (
ID number(10) primary key,
NUME VARCHAR2(255),
PRENUME VARCHAR2(255),
DATA_NASTERE DATE,
TELEFON VARCHAR2(10) unique,
ADRESA_EMAIL VARCHAR2(255)unique
);
/

set serveroutput on;

DECLARE 

Cursor s_cursor IS select name from USERS ;

v_name USERS.NAME%TYPE;
s_nume S_USERS.NUME%TYPE;
s_prenume S_USERS.PRENUME%TYPE;
s_prenume2 S_USERS.PRENUME%TYPE;
nr_prenume NUMBER(1);
data_nastere DATE;
id_nr  USERS.ID%TYPE;
s_telefon VARCHAR2(10);
v_random_numbers VARCHAR2(10);
s_email VARCHAR2(100);

BEGIN
id_nr:=1;
Open s_cursor;
  LOOP 
    FETCH s_cursor into v_name;
    EXIT WHEN s_cursor%NOTFOUND;
    s_nume:= upper(substr(v_name, instr(v_name,' ')+1));
    nr_prenume:= DBMS_RANDOM.value(1,2);
    CASE (nr_prenume)  
      WHEN 1 THEN  
      SELECT initcap(regexp_substr(name,'(\S*)(\s)')) into s_prenume FROM ( SELECT name FROM USERS ORDER BY dbms_random.value ) WHERE rownum = 1;
      s_prenume2:='';
      ELSE
         SELECT initcap(regexp_substr(name,'(\S*)(\s)')) into s_prenume FROM ( SELECT name FROM USERS ORDER BY dbms_random.value ) WHERE rownum = 1;
        IF((SUBSTR(trim(s_prenume), -1) = 'a')) THEN
          --DBMS_OUTPUT.PUT_LINE('cu A '||s_prenume);
          SELECT initcap(regexp_substr(name,'(\S*)(\s)')) into s_prenume2 FROM ( SELECT name FROM USERS ORDER BY dbms_random.value ) WHERE SUBSTR(trim(initcap(regexp_substr(name,'(\S*)(\s)'))),-1)='a' and  rownum = 1;
       ELSE
        -- DBMS_OUTPUT.PUT_LINE('FARA A '||s_prenume);
         SELECT initcap(regexp_substr(name,'(\S*)(\s)')) into s_prenume2 FROM ( SELECT name FROM USERS ORDER BY dbms_random.value ) WHERE SUBSTR(trim(initcap(regexp_substr(name,'(\S*)(\s)'))),-1)!='a' and  rownum = 1;
       END IF;
      
    END CASE;
  s_prenume:=s_prenume||s_prenume2;
  data_nastere:=TO_DATE(TRUNC(DBMS_RANDOM.VALUE(TO_NUMBER(TO_CHAR(TO_DATE('01/01/1997', 'MM/DD/YYYY'), 'J')),  TO_NUMBER(TO_CHAR(TO_DATE('12/31/1997', 'MM/DD/YYYY'), 'J')))), 'J'); 
  v_random_numbers:=floor(dbms_random.value(10000000,99999999));
  s_telefon:='07'||v_random_numbers;
  s_email:=lOWER(TRIM(s_nume))||id_nr||'@yahoo.com';
  INSERT INTO S_USERS(ID,NUME,PRENUME,data_nastere,TELEFON,ADRESA_EMAIL) values (id_nr,s_nume,s_prenume,data_nastere,s_telefon,s_email);

  id_nr:=id_nr+1;
  END LOOP;
  CLOSE s_cursor;
  
END;


SELECT * FROM S_USERS;


