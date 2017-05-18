CREATE OR REPLACE PROCEDURE ex1 IS
v_CursorID NUMBER;
v_CreateTableString VARCHAR2(500);
v_NUMRows INTEGER;
v_InsertRecords VARCHAR2(500);
v_tableName VARCHAR2(100);
CURSOR studenti IS SELECT username, id FROM ( SELECT u.username, u.id,  COUNT(r.user_id) FROM USERS u JOIN reports r on r.user_id=u.id group by u.username, u.id order by count(r.user_id) desc)
where rownum<=10;
v_linie studenti%ROWTYPE;
it NUMBER(2) :=1;
v_puturos NUMBER;
v_nr_intrebari NUMBER;
v_nr_intrebari_relevante NUMBER;
v_nr_reports NUMBER;
v_nr_reports_wrong NUMBER;

BEGIN
FOR v_linie in studenti LOOP

IF it<11 THEN 

v_tableName:= 'u'||v_linie.id;
v_CursorId:= DBMS_SQL.OPEN_CURSOR;
v_CreateTableString:= 'CREATE TABLE '||RTRIM(v_tableName)||'(
    id NUMBER(10),
    name VARCHAR2(50),
    puturos NUMBER(2),
    nr_intrebari NUMBER(4),
    nr_intrebari_relevante NUMBER(4),
    nr_reports NUMBER(4),
    nr_reports_wrong NUMBER(4))';
    

DBMS_SQL.PARSE(v_CursorID,v_CreateTableString,DBMS_SQL.V7); 
v_NumRows := DBMS_SQL.EXECUTE(v_CursorID);
DBMS_OUTPUT.PUT_LINE(v_tableName||' creat!');

v_InsertRecords:='INSERT INTO '||v_tableName||'(id, name, puturos, nr_intrebari, nr_intrebari_relevante, nr_reports, nr_reports_wrong)
    VALUES(:myid, :myname, :myputuros, :mynr_intrebari, :mynr_intrebari_relevante, :mynr_reports, :mynr_reports_wrong)';
DBMS_SQL.PARSE(v_CursorID, v_InsertRecords, DBMS_SQL.V7);
v_puturos:=found_lazy(v_linie.id);
select count(user_id) into v_nr_intrebari from questions where user_id=v_linie.id;
v_nr_intrebari_relevante:=get_relevant_by_user(v_linie.username);
select COUNT(r.user_id)into v_nr_reports FROM USERS u JOIN reports r on r.user_id=u.id where u.id=v_linie.id;
v_nr_reports_wrong:=30;
DBMS_SQL.BIND_VARIABLE(v_CursorID, ':myid' , v_linie.id);
DBMS_SQL.BIND_VARIABLE(v_CursorID, ':myname', v_linie.username);
DBMS_SQL.BIND_VARIABLE(v_CursorID, ':myputuros', v_puturos);
DBMS_SQL.BIND_VARIABLE(v_CursorID, ':mynr_intrebari', v_nr_intrebari);
DBMS_SQL.BIND_VARIABLE(v_CursorID, 'mynr_intrebari_relevante', v_nr_intrebari_relevante);
DBMS_SQL.BIND_VARIABLE(v_CursorID, 'mynr_reports', v_nr_reports);
DBMS_SQL.BIND_VARIABLE(v_CursorID, 'mynr_reports_wrong', v_nr_reports_wrong);
v_NumRows := DBMS_SQL.EXECUTE(v_CursorID);

it:=it+1;
END IF;
END LOOP;
END;
/


Create or replace procedure delete_table AS
v_CursorID NUMBER;
v_tableName VARCHAR2(500);
v_Interogare VARCHAR2(500);
v_NumRows INTEGER;
CURSOR studenti IS SELECT username, id FROM ( SELECT u.username, u.id,  COUNT(r.user_id) FROM USERS u JOIN reports r on r.user_id=u.id group by u.username, u.id order by count(r.user_id) desc)
where rownum<=10;
v_linie studenti%ROWTYPE;
it NUMBER(2) :=1;

BEGIN
FOR v_linie in studenti LOOP

IF it<11 THEN 

v_tableName:= 'u'||v_linie.id;
v_CursorId:= DBMS_SQL.OPEN_CURSOR;
v_Interogare:='DROP TABLE '||v_tableName;
DBMS_SQL.PARSE(v_CursorID,v_Interogare,DBMS_SQL.V7); 
v_NumRows := DBMS_SQL.EXECUTE(v_CursorID);
DBMS_OUTPUT.PUT_LINE(v_tableName||' sters');
END IF;
END LOOP;
END;


set SERVEROUTPUT ON;
DECLARE
BEGIN
ex1();
end;
