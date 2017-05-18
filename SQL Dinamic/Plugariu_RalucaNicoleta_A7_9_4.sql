Create or replace procedure clonare( sursa in Varchar2,destinatie in Varchar2) as
v_CursorID NUMBER;
v_CreateTableString VARCHAR2(500);
v_NUMRows INTEGER;
Begin

v_CursorId:= DBMS_SQL.OPEN_CURSOR;
v_CreateTableString:= 'CREATE TABLE '||destinatie||' as select * from '||sursa;

DBMS_SQL.PARSE(v_CursorID,v_CreateTableString,DBMS_SQL.V7); 
v_NumRows := DBMS_SQL.EXECUTE(v_CursorID);
DBMS_OUTPUT.PUT_LINE(destinatie||' creat!');

End;



set SERVEROUTPUT ON;
DECLARE
BEGIN
clonare('intrebare4501','tabelNou');
end;



