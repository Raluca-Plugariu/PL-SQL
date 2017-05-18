Create or replace procedure ex3 is
v_CursorID NUMBER;
v_CreateTableString VARCHAR2(500);
v_NUMRows INTEGER;
v_InsertRecord VARCHAR2(500);
v_tableName VARCHAR2(100);
cursor intrebari is select id, user_id, asked, solved, created_at from questions where cast(created_at as DATE)>=TO_DATE('01/15/2017','MM/DD/YYYY') and reported>5;
v_linie intrebari%ROWTYPE;
v_user Varchar2(500);
v_InsertRecords Varchar2(500);

BEGIN
FOR v_linie in intrebari LOOP

v_tableName:= 'intrebare'||v_linie.id;
select username into v_user from users where id=v_linie.user_id;
v_CursorId:= DBMS_SQL.OPEN_CURSOR;
v_CreateTableString:= 'CREATE TABLE '||RTRIM(v_tableName)||'(
    name VARCHAR2(50),
    nr_rezolvari NUMBER,
    nr_rezolvari_corecte NUMBER,
    data_creare TIMESTAMP)';
    

DBMS_SQL.PARSE(v_CursorID,v_CreateTableString,DBMS_SQL.V7); 
v_NumRows := DBMS_SQL.EXECUTE(v_CursorID);
DBMS_OUTPUT.PUT_LINE(v_tableName||' creat!');


v_InsertRecord:='INSERT INTO '||v_tableName||'(name, nr_rezolvari, nr_rezolvari_corecte, data_creare)
    VALUES( :myname, :mynr_rezolvari, :mynr_rezolvari_corecte, :mydata_creare )';
DBMS_SQL.PARSE(v_CursorID, v_InsertRecord, DBMS_SQL.V7);

DBMS_SQL.BIND_VARIABLE(v_CursorID, ':myname', v_user);
DBMS_SQL.BIND_VARIABLE(v_CursorID, ':mynr_rezolvari', v_linie.asked);
DBMS_SQL.BIND_VARIABLE(v_CursorID, ':mynr_rezolvari_corecte', v_linie.solved);
DBMS_SQL.BIND_VARIABLE(v_CursorID, ':mydata_creare', v_linie.created_at);
v_NumRows := DBMS_SQL.EXECUTE(v_CursorID);

END LOOP;
END;



set SERVEROUTPUT ON;
declare

begin
ex3();
end;
