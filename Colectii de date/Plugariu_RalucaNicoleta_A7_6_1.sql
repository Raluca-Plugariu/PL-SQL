set serveroutput on;

create or replace function aliniere(maxim NUMBER, value NUMBER)
RETURN VARCHAR IS
begin
return lpad(value, maxim, ' ');
end;
/
DECLARE

TYPE v_numbers is table of NUMBER index by pls_integer;
TYPE v_numbers_rec is record
(
  numbers v_numbers
);
TYPE v_numbers_matrix is table of v_numbers_rec index by pls_integer;
matrix v_numbers_matrix;
matrix_2 v_numbers_matrix;
result_matrix v_numbers_matrix;
linii_1 NUMBER;
coloane_1 NUMBER;
coloane_2 NUMBER;
v_max NUMBER;
BEGIN
 linii_1:= floor(dbms_random.value(2,5));
 coloane_1:= floor(dbms_random.value(2,5));
 coloane_2:= floor(dbms_random.value(2,5));
 
 DBMS_OUTPUT.PUT_LINE('Prima matrice este: ');
 for i in 1 .. linii_1 loop
    for j in 1 .. coloane_1 loop
     matrix(i).numbers(j):= floor(dbms_random.value(0,20));
     dbms_output.put(aliniere(2,matrix(i).numbers(j))||' ');
     end loop;
     dbms_output.put_line(' ');
     end loop;
          
     DBMS_OUTPUT.PUT_LINE('A doua matrice este: ');     
 for i in 1 .. coloane_1 loop
    for j in 1 .. coloane_2 loop
     matrix_2(i).numbers(j):= floor(dbms_random.value(0,20));
      dbms_output.put(aliniere(2,matrix_2(i).numbers(j))||' ');
     end loop;
      dbms_output.put_line(' ');
     end loop;
       DBMS_OUTPUT.PUT_LINE('Rezultatul inmultirii este: ');
       v_max:=1;
  for i in 1 .. linii_1 loop
    for j in 1..coloane_2 loop
       result_matrix(i).numbers(j):=0;
       for k in 1 .. coloane_1 loop
         result_matrix(i).numbers(j):=result_matrix(i).numbers(j)+ matrix(i).numbers(k) * matrix_2(k).numbers(j);
         end loop;
         if(length(result_matrix(i).numbers(j))>v_max) then
         v_max:=length(result_matrix(i).numbers(j));
         end if;
         end loop;
         end loop;
         
  for i in 1 .. linii_1 loop
    for j in 1..coloane_2 loop
   dbms_output.put(aliniere(v_max,result_matrix(i).numbers(j))||' ');
    end loop;
    DBMS_OUTPUT.PUT_LINE(' ');
    END LOOP;
END;