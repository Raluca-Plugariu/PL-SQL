set serveroutput on;
DECLARE
CURSOR curs IS select * from persoane;
TYPE linie_student IS TABLE OF curs%ROWTYPE;
lista_studenti linie_student;
sir_prenume persoane.prenume%type;
find INTEGER;
counter NUMBER :=0;
idx NUMBER;
j NUMBER;

BEGIN
open curs;
select * bulk collect into lista_studenti from persoane;
close curs;
for i in lista_studenti.first .. lista_studenti.last loop

 find:=0;
 idx:=1;
 WHILE (IDX <=lista_studenti(i).prenume.count and find = 0 ) LOOP
  IF(REGEXP_COUNT(lista_studenti(i).prenume(idx),'u')>=1)
  THEN
      COUNTER:=COUNTER+1;
      find:=1;
  END IF;
  IDX:=IDX+1;
  END LOOP;
  if(find=1) then
    dbms_output.put(lista_studenti(i).nume||' ');
    for j in 1..lista_studenti(i).prenume.count loop
      dbms_output.put(lista_studenti(i).prenume(j)||' ');
      end loop;
    end if;
    dbms_output.put_line(' ');
END LOOP;
  dbms_output.put_line('Nr de persoane care au macar o litera "u" in prenume este: '|| counter);
  
  end;

