set serveroutput on;
DECLARE
CURSOR lista_id IS select q.id from Questions q join users u on q.user_id=u.id where u.user_role='user' and q.id>120 and q.id<140;
v_linie questions.id%type;
v_max questions.id%type;
v_relevanta NUMBER;
v_name users.name%type;
v_remember NUMBER;

BEGIN
v_max:=0;

OPEN lista_id;
LOOP
    FETCH lista_id INTO v_linie;
    EXIT WHEN lista_id%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE('Intrebarea '||v_linie||' are relevanta '||get_relevant(v_linie));
    IF(get_relevant(v_linie)>v_max)
    THEN
       v_max:=get_relevant(v_linie);
       v_remember:=v_linie;
    END IF;
    DBMS_OUTPUT.PUT_LINE(v_linie);
END LOOP;
CLOSE lista_id;
select name into v_name from users u join questions q on u.id=q.user_id where q.id=v_remember and u.user_role='user';
DBMS_OUTPUT.PUT_LINE('Intrebarea cu relevanta cea mai mare apartine studentului '||v_name||' si are valoarea: '||v_max);
END;