DECLARE
CURSOR update_reports IS select* from QUESTIONS FOR UPDATE OF REPORT_RESOLVED;
CURSOR lista_users Is select s.name as from Users s join QUESTIONS p on s.id=p.user_id where p.REPORT_RESOLVED=2 group by s.name;

v_linie  update_reports%ROWTYPE;
v_data DATE;
v_user lista_users%ROWTYPE;
v_nr_intrebari NUMBER(10);

BEGIN
v_data:=TO_DATE('01/15/2017','MM/DD/YYYY');
OPEN update_reports;
LOOP
   FETCH update_reports INTO v_linie;
   EXIT WHEN update_reports%NOTFOUND;
    IF(v_linie.reported>=5 and cast(v_linie.updated_at as DATE)>=v_data)
    THEN
       UPDATE QUESTIONS SET REPORT_RESOLVED=2 WHERE CURRENT OF update_reports;
    END IF;
    END LOOP;
    FOR v_user IN lista_users LOOP
        select count(p.report_resolved) Into v_nr_intrebari from Users s join QUESTIONS p on s.id=p.user_id where s.name=v_user.name and p.report_resolved=2;
         DBMS_OUTPUT.PUT_LINE(v_user.name||' '||v_nr_intrebari);
         END LOOP;
    
END; 