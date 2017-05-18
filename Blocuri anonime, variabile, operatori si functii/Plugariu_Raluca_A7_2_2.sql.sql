set serveroutput on;
<<global>>
DECLARE
  masina varchar2(20):='VW Golf';
  an number(20):=2004;
BEGIN
<<subglobal>>
      DECLARE
          masina VARCHAR2(20):='Audi A3';
          an number(20):=2006;
      BEGIN
        DECLARE
             masina VARCHAR2(20):='VW Passat';
             an number(20):=2009;
         BEGIN
            DBMS_OUTPUT.PUT_LINE('Modelul masinii este '||masina||' si este din anul ' || an); --Modelul masinii este VW Passat si este din anul 2009
            DBMS_OUTPUT.PUT_LINE('Modelul masinii este '||subglobal.masina||' si este din anul ' || subglobal.an); --Modelul masinii este Audi A3 si este din anul 2006
            DBMS_OUTPUT.PUT_LINE('Modelul masinii este '||global.masina||' si este din anul ' || global.an); -- Modelul masinii este VW Golf si este din anul 2004
         END;
         DBMS_OUTPUT.PUT_LINE('Modelul masinii este '||masina||' si este din anul ' ||an); --Modelul masinii este Audi A3 si este din anul 2006
         DBMS_OUTPUT.PUT_LINE('Modelul masinii este '||global.masina||' si este din anul ' || global.an);--Modelul masinii este VW Golf si este din anul 2004
   END;
   DBMS_OUTPUT.PUT_LINE('Modelul masinii este '||masina||' si este din anul ' || an);--Modelul masinii este VW Golf si este din anul 2004
END;
