CREATE OR REPLACE TYPE animal as OBJECT(
culoare varchar2(10),
data_nastere date,
nume varchar2(10),
specie varchar2(10),
not final member procedure afiseaza_specia,
map member function calc_varsta return number,
constructor function animal(culoare varchar2,nume varchar2, specie varchar2) return self as result
)NOT FINAL;
/

Create or replace type body animal as
Member procedure afiseaza_specia AS
Begin
    DBMS_OUTPUT.PUT_LINE(nume||' este din specia" '|| specie);
END;

Map Member function calc_varsta return NUMBER as
Begin
RETURN TRUNC(MONTHS_BETWEEN(SYSDATE,DATA_NASTERE)/12);
END;

Constructor Function animal(culoare varchar2, nume varchar2,specie varchar2)
RETURN SELF AS RESULT
AS
BEGIN
SELF.nume:=nume;
SELF.culoare:=culoare;
SELF.specie:=specie;
SELF.data_nastere:=sysdate;
RETURN;
END;
END;
/

CREATE OR REPLACE TYPE maimuta UNDER animal(
tip VARCHAR2(10),
OVERRIDING member procedure afiseaza_specia,
member function calc_varsta(x NUMBER) RETURN NUMBER
)
/
CREATE OR REPLACE TYPE BODY maimuta AS
OVERRIDING member procedure afiseaza_specia IS
BEGIN
    DBMS_OUTPUT.PUT_LINE(nume||' este din specia '||specie||' de tipul '|| tip);
END afiseaza_specia;

Member function calc_varsta(x number) return NUMBER as
BEGIN
RETURN TRUNC(MONTHS_BETWEEN(SYSDATE,DATA_NASTERE)/12)+x;
END;
END;
/




drop table animale;
CREATE TABLE animale(nr_crt VARCHAR2(4), obiect ANIMAL);

set serveroutput on;
DECLARE
v_animal1 ANIMAL;
v_animal2 ANIMAL;
v_maimuta MAIMUTA;
Begin
v_animal1:= animal('negru', TO_DATE('11/04/1994', 'dd/mm/yyyy'), 'Azor', 'caine');
v_animal2:= animal('maro', TO_DATE('22/03/1995', 'dd/mm/yyyy'), 'Martinica', 'urs');
insert into animale values ('100', v_animal1);
insert into animale values ('200', v_animal2);
v_maimuta:= maimuta('maro', TO_DATE('11/03/1999', 'dd/mm/yyyy'), 'Bobo', 'primata' , 'babuin');
v_maimuta.afiseaza_specia();
dbms_output.put_line(v_animal2.calc_varsta);
dbms_output.put_line(v_maimuta.calc_varsta);
dbms_output.put_line(v_maimuta.calc_varsta(5));

end;

select * from animale order by 2;




