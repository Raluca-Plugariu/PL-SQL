DECLARE
TYPE nume_typ IS TABLE OF S_USERS.NUME%TYPE INDEX BY PLS_INTEGER;
nume_familie nume_typ;
TYPE prenume_typ IS TABLE OF S_USERS.PRENUME%TYPE INDEX BY PLS_INTEGER;
prenume prenume_typ;
BEGIN

SELECT nume, prenume
      BULK COLLECT INTO nume_familie, prenume
      FROM S_USERS where SUBSTR(trim(prenume),-1)!='a';

  DBMS_OUTPUT.PUT_LINE('Baieti:'||prenume.LAST);
  
END;