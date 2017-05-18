set serveroutput on;
DECLARE
id1 number(10):=304;
id2 number(10):=79;
questions_1 int;
questions_2 int;
answer_1 int;
answer_2 int;

BEGIN
select count(ID) into questions_1 from QUESTIONS where user_id=id1;
select count(ID) into questions_2 from QUESTIONS where user_id=id2;
select count(SOLVED) into answer_1 from ANSWERS where user_id=id1;
select count(SOLVED) into answer_2 from ANSWERS where user_id=id2;

IF (questions_1 = questions_2)
  THEN
    IF (answer_1 > answer_2)
      THEN DBMS_OUTPUT.PUT_LINE('Ambii studenti au introdus acelasi numar de intrebari insa studentul cu id-ul ' || id1|| 'a raspuns la mai multe intrebari');
      ELSE DBMS_OUTPUT.PUT_LINE('Ambii studenti id-uri au introdus acelasi numar de intrebari insa studentul cu id-ul ' || id2|| 'a raspuns la mai multe intrebari');
   END IF;
ELSE
   IF (questions_1>questions_2)
     THEN DBMS_OUTPUT.PUT_LINE('Studentul cu id-ul ' || id1 || ' a introdus mai multe intrebari decat studentul cu id-ul '||id2);
    ELSE  DBMS_OUTPUT.PUT_LINE('Studentul cu id-ul ' || id2 || ' a introdus mai multe intrebari decat studentul cu id-ul '||id1);
    END IF;
END IF;

END;
  
    
    



