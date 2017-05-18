set serveroutput on;
CREATE OR REPLACE PACKAGE exercitiul_1 IS
FUNCTION found_lazy(p_id NUMBER) RETURN NUMBER;
FUNCTION get_relevant(z_id NUMBER) RETURN NUMBER;
FUNCTION get_relevant_by_user(z_username USERS.USERNAME%TYPE) RETURN NUMBER;
END exercitiul_1;
/
CREATE OR REPLACE PACKAGE BODY exercitiul_1 IS
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

FUNCTION get_relevant(z_id NUMBER)
RETURN NUMBER AS
v_relevanta NUMBER;
v_asked NUMBER;
v_resolved NUMBER;

BEGIN
v_relevanta:=0;
select sum(solved) into v_resolved from ANSWERS where QUESTION_ID=z_id AND found_lazy(user_id)>0 and solved=1; 
select asked into v_asked from questions where id=z_id ;
IF(v_asked<20) 
THEN
  RETURN v_relevanta;
ELSE
    IF(floor(v_resolved/v_asked*100)<30 or floor(v_resolved/v_asked*100)>90)
    THEN 
    RETURN v_relevanta;
    ELSE
    RETURN v_asked;
    END IF;
END IF;
END;

FUNCTION get_relevant_by_user(z_username USERS.USERNAME%TYPE) 
RETURN NUMBER IS
CURSOR lista_intrebari IS select q.id from users u join questions q on q.user_id=u.id where u.username=z_username;
v_question_id questions.id%type;
v_relevanta NUMBER;
v_asked NUMBER;
v_resolved NUMBER;
v_max questions.id%type :=0;
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
   
  IF(v_relevanta>v_max)
  THEN
    v_max:=v_relevanta;
    v_remember:=v_question_id;
  END IF;
 END LOOP;
CLOSE lista_intrebari;
RETURN v_max;
END;
END exercitiul_1;
/

DECLARE 
p_user_name users.username%type;
v_maxim NUMBER;
BEGIN
p_user_name:='raluca.plugariu';
DBMS_OUTPUT.PUT_LINE(exercitiul_1.get_relevant(566));
DBMS_OUTPUT.PUT_LINE(exercitiul_1.found_lazy(1));
DBMS_OUTPUT.PUT_LINE('Intrebarea cu cea mai mare relevanta a studentului cu username-ul: '||p_user_name||' este '||exercitiul_1.get_relevant_by_user(p_user_name));
END;

