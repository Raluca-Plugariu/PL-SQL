set serveroutput on;
CREATE OR REPLACE TYPE t_student as OBJECT( nume varchar2(255),prenume varchar2(255));
/
CREATE OR REPLACE TYPE varr IS VARRAY(3) OF t_student;
/
CREATE OR REPLACE PACKAGE exercitiul_3 IS
FUNCTION found_lazy(p_id NUMBER) RETURN NUMBER;
FUNCTION get_relevant_by_user(z_username users.username%type) RETURN NUMBER;
END exercitiul_3;
/
CREATE OR REPLACE PACKAGE BODY exercitiul_3 IS
FUNCTION found_lazy(p_id NUMBER)
RETURN NUMBER IS
v_solved_questions NUMBER;
v_questions NUMBER;
v_rezult NUMBER;
BEGIN
v_rezult:=0;
 select count(*) into v_questions from Users u join Answers q on u.id=q.user_id WHERE u.id=p_id;
 select count(*) into v_solved_questions from Users u join Answers q on u.id=q.user_id where u.id=p_id and solved=1;
 IF(v_solved_questions < floor(v_questions/2))
 THEN
  return v_rezult;
 ELSE 
  return (v_rezult+1);
   END IF;
END;
FUNCTION get_relevant_by_user(z_username users.username%type) 
RETURN NUMBER IS
CURSOR lista_intrebari IS select q.id from users u join questions q on q.user_id=u.id where u.username= z_username;
v_question_id questions.id%type;
v_relevanta NUMBER;
v_asked NUMBER;
v_resolved NUMBER;
v_counter questions.id%type :=0;
v_remember NUMBER;
BEGIN
 OPEN lista_intrebari;
 LOOP
    FETCH lista_intrebari into v_question_id;
    EXIT WHEN lista_intrebari%NOTFOUND;
    v_relevanta:=0;
   select sum(solved) into v_resolved from ANSWERS where QUESTION_ID=v_question_id AND found_lazy(user_id)>0 and solved=1; 
   select asked into v_asked from questions where id=v_question_id ;
   IF(v_asked<20) 
   THEN
    v_relevanta:=0;
   ELSE
      IF(floor(v_resolved/v_asked*100)<30 or floor(v_resolved/v_asked*100)>90)
      THEN 
        v_relevanta:=0;
      ELSE
        v_relevanta:=v_asked;
      END IF; 
   END IF;
   
  If(v_relevanta>0) then
   v_counter:=v_counter+1;
   end if;
 END LOOP;
CLOSE lista_intrebari;
RETURN v_counter;
END;
END exercitiul_3;
/
create or replace PROCEDURE fumc(v_student t_student)
AS
    v_username VARCHAR2(255);
BEGIN
    v_username:=v_student.prenume||'.'||v_student.nume;
    DBMS_OUTPUT.PUT_LINE('Numarul de intrebari relevante pentru '||v_username||' este '||exercitiul_3.get_relevant_by_user(v_username));
END;
/
DECLARE 
v_student t_student;
lista varr;
BEGIN
lista:= varr(t_student('motrescu','tudor'), t_student('plugariu','raluca'), t_student('vicol', 'robert'));
for i in 1..3 loop 
fumc(lista(i));
end loop;

END;
