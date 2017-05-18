set serveroutput on;
select name from users where name like '%aluca%';
DECLARE
Nume VARCHAR2(30);
idStudent USERS.ID%type;
numefullStudent USERS.name%type;
numeStudent USERS.name%type;
prenumeStudent USERS.name%type;
numarIntrebari number(10);
v_number_of_students number(10);


BEGIN
Nume:='%'||'&x'||'%';
--DBMS_OUTPUT.PUT_LINE(Nume);
select count(id) into v_number_of_students from users where name like Nume;
with mySelect as (SELECT name,id from(
select rownum,name,id from Users where name like Nume order by ID)
 order by trunc(DBMS_RANDOM.value(1,v_number_of_students)))
 select id,name into idStudent,numefullStudent from mySelect where rownum<=1;

select count(q.id) into numarIntrebari from Users u inner join Questions q on q.user_id=u.id  where u.id = idStudent and q.reported<5 ;

numeStudent:=upper(substr(numefullStudent, instr(numefullStudent,' ')+1));
prenumeStudent:=initcap(regexp_substr(numefullStudent,'(\S*)(\s)')); 

DBMS_OUTPUT.PUT_LINE('ID-ul studentului : ' || idStudent);
DBMS_OUTPUT.PUT_LINE('Numele : ' || numeStudent);
DBMS_OUTPUT.PUT_LINE('Prenumele : '||prenumeStudent);
DBMS_OUTPUT.PUT_LINE('Numarul de intrebari ce au fost puse in sistem si au avut mai putin de 5
raportari : ' || numarIntrebari);
DBMS_OUTPUT.PUT_LINE(trunc(DBMS_RANDOM.value(1,v_number_of_students)));


END;