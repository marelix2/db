execute block
returns (
    imienazwisko varchar(75),
    pesel char(11),
    kodpocztowy varchar(8),
    poczta varchar(30),
    ulica varchar(50),
    nrdomu char(7),
    nrlokalu char(7),
    RNEWkodkontrahenta integer,
    RkodOsSprSad integer,
    RkodSprSad integer,
    Rkodlokalu integer)
as
declare variable LKodkontrahentaTMP integer;
declare variable  RkodlokaluTMP integer;
declare variable  Lkodx_err integer;


BEGIN
RkodlokaluTMP = null;
LKodkontrahentaTMP = null;

  FOR
  select
  kf.rkodlokalu,
  oss.kodosobysprsad, oss.kodsprsad, oss.xkodkontrahenta,
     oss.imienazwisko, oss.pesel,oss.kodpocztowy, oss.poczta, oss.ulica, oss.nrdomu, oss.nrlokalu
    
    from czspr_kartylokalifiltru('2016-11-18',1,null, null, null, null,1,'W') kf
    
    left outer join cz_sprawysadowe ss on kf.rkodlokalu = ss.kodlokalu
    
    left outer join ss_osobysprsad oss on ((oss.kodsprsad = ss.kodsprsad) and (oss.wskdlgl = 'N'))
    where oss.imienazwisko is not null  and oss.xkodkontrahenta is not null
    order by    kf.rkodlokalu, oss.xkodkontrahenta
    INTO :Rkodlokalu,
    :RkodOsSprSad,
    :RkodSprSad,
    :RNEWkodkontrahenta,
    :IMIENAZWISKO,
         :PESEL,
         :KODPOCZTOWY,
         :POCZTA,
         :ULICA,
         :NRDOMU,
         :NRLOKALU
  DO
  BEGIN

  if (/*((:RkodlokaluTMP is null) or (:RkodlokaluTMP <> :Rkodlokalu)) and*/ ((:LKodkontrahentaTMP is null) or (:LKodkontrahentaTMP <> :RNEWkodkontrahenta))) then
  Begin
  insert into  cz_kontrlok  (kodfirmy, kodlokalu, kodkontrahenta, obowoddnia, symbolstatkl) values (null, :Rkodlokalu, :RNEWkodkontrahenta, '1900-01-01','DS');
  end


  INSERT INTO CZ_OSOBYSPRSAD (KODSPRSAD, KODKONTRAHENTA, WYSLANYDOKRD) VALUES (:RkodSprSad, :RNEWkodkontrahenta, 'N');
/*suspend;*/


  RkodlokaluTMP = :Rkodlokalu;
  LKodkontrahentaTMP = :RNEWkodkontrahenta;

     when any do
begin
Lkodx_err = gen_id(x_err_log,1);
insert into x_err_log  (kod,txt1, txt2, txt3, int1, int2, int3) values (:Lkodx_err,null,'zakladanie kontr lokalu i ss', ' kod lok i kod spr i kod kontr',:Rkodlokalu,:RkodSprSad,:RNEWkodkontrahenta);
 /* exception;*/
end


  END
END