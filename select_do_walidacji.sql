select 
 replace(rlok_adres,' ',''),
 replace(replace(rkn_miejsce,rkn_poczta||',', ''),' ', ''),
 rkn_miejsce,
upper(rlok_kodpocztowy) ,
upper(rlok_poczta),
upper(rkn_kodpocztowy) ,
upper(rkn_poczta)
from table(czspr_kartylokalifiltru( '2010-09-07',1, null, null,null,null,140, null))
where 
((  substr(replace(rlok_adres,' ',''),0,instr(replace(rlok_adres,' ',''),'/',1)) not like
    substr(replace(rlok_adres,' ',''),0,instr(replace(rlok_adres,' ',''),'/',1))
    and 
    substr(replace(rlok_adres,' ',''),instr(replace(rlok_adres,' ',''),'/',1)+1) not like 
    substr(replace(replace(rkn_miejsce,rkn_poczta||',', ''),' ', ''),instr(replace(replace(rkn_miejsce,rkn_poczta||',', ''),' ', ''),'/',1)+1)))
or 
 (  length(substr(replace(rlok_adres,' ',''),instr(replace(rlok_adres,' ',''),'/',1)+1)) != 
    length(substr(replace(replace(rkn_miejsce,rkn_poczta||',', ''),' ', ''),instr(replace(replace(rkn_miejsce,rkn_poczta||',', ''),' ', ''),'/',1)+1))
   and 
   (
   substr(replace(rlok_adres,' ',''),instr(replace(rlok_adres,' ',''),'/',1)+1) not like 
   '0'|| substr(replace(replace(rkn_miejsce,rkn_poczta||',', ''),' ', ''),instr(replace(replace(rkn_miejsce,rkn_poczta||',', ''),' ', ''),'/',1)+1)
   )
   and 
 (  length(substr(replace(rlok_adres,' ',''),instr(replace(rlok_adres,' ',''),'/',1)+1)) != 
    length(substr(replace(replace(rkn_miejsce,rkn_poczta||',', ''),' ', ''),instr(replace(replace(rkn_miejsce,rkn_poczta||',', ''),' ', ''),'/',1)+1))
   and 
   (
   substr(replace(rlok_adres,' ',''),instr(replace(rlok_adres,' ',''),'/',1)+1) not like 
   '00'|| substr(replace(replace(rkn_miejsce,rkn_poczta||',', ''),' ', ''),instr(replace(replace(rkn_miejsce,rkn_poczta||',', ''),' ', ''),'/',1)+1)
   )
    )
    )
or    
    upper(rkn_kodpocztowy)  not like upper(rlok_kodpocztowy)
or    
    upper(rkn_poczta)  not like upper(rlok_poczta);