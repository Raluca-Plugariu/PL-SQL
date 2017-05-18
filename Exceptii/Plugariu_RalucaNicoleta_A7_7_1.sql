CREATE TABLE NEW_QUESTIONS(
ID	NUMBER(10,0),
CHAPTER_ID	NUMBER(10,0),
USER_ID	NUMBER(10,0),
QUESTION	CLOB,
ANSWER	CLOB,
ASKED	NUMBER(10,0),
SOLVED	NUMBER(10,0),
REPORTED	NUMBER(10,0),
REPORT_RESOLVED	NUMBER(10,0),
CREATED_AT	TIMESTAMP(6),
UPDATED_AT	TIMESTAMP(6)
);

create or replace PROCEDURE verify_question(p_id QUESTIONS.ID%TYPE) AS
v_relevanta NUMBER;
gasit NUMBER;
double_question NUMBER;
relevanta_0 EXCEPTION;
inexistent_id EXCEPTION;
intrebare_duplicat EXCEPTION;
BEGIN
gasit:=0; 
select count(*)into gasit from questions where id=p_id;
select count(*) into double_question from new_questions where id=p_id; 
if gasit= 0 then
raise inexistent_id;
else
if double_question=0 then 
v_relevanta:=get_relevant(p_id);
IF v_relevanta > 0 THEN

     INSERT INTO NEW_QUESTIONS(ID, CHAPTER_ID, USER_ID, QUESTION, ANSWER, ASKED, SOLVED, REPORTED, REPORT_RESOLVED, CREATED_AT, UPDATED_AT)
    SELECT ID, CHAPTER_ID, USER_ID, QUESTION, ANSWER, ASKED, SOLVED, REPORTED, REPORT_RESOLVED, CREATED_AT, UPDATED_AT 
    FROM QUESTIONS WHERE ID=p_id;


ELSE
    IF v_relevanta = 0 then
    raise relevanta_0;
   end if;
END IF;
else 
raise intrebare_duplicat;
end if;
end if;
EXCEPTION
WHEN relevanta_0 THEN
   DBMS_OUTPUT.PUT_LINE('relevanta este 0');
WHEN inexistent_id THEN
    DBMS_OUTPUT.PUT_LINE('nu exista intrebarea');
WHEN intrebare_duplicat THEN
    DBMS_OUTPUT.PUT_LINE('exista deja intrebarea in tabel');


END verify_question;


CREATE OR REPLACE PROCEDURE adaugare AS
Cursor lista_intrebari IS select id from QUESTIONS;
v_id QUESTIONS.ID%TYPE;
nr_intrebari NUMBER;

BEGIN
OPEN lista_intrebari;
LOOP
select count(*)into nr_intrebari from new_questions;
    FETCH lista_intrebari into v_id;
    EXIT WHEN nr_intrebari=1000;
    verify_question(v_id);
END LOOP;
END adaugare;


SET SERVEROUTPUT ON;
  DECLARE
  BEGIN
  adaugare();
  
  END;