
drop table przedmiot;
drop table nauczyciel;
drop table klasa;
drop table uczen;
drop table oceny;
drop table lekcje;
--------------------------------------------
create table przedmiot(
id_przedmiotu integer not null,
nazwa_przedmiotu VARCHAR(200) not null,
ilosc_h integer not null

);

create table nauczyciel(
id_nauczyciela integer not null,
Imie VARCHAR(200) not null,
Nazwisko VARCHAR(200) not null,
id_przedmiotu integer not null

);


create table klasa(

id_klasy integer not null,
profil_klasy VARCHAR(200) not null,
litera VARCHAR(2) not null

);

create table uczen(

id_ucznia integer not null,
Imie VARCHAR(200) not null,
Nazwisko VARCHAR(200) not null,
wiek integer,
id_klasy integer not null

);

create table oceny(
id_oceny integer not null,	
id_nauczyciela integer not null,	
id_ucznia integer not null,	
ocena integer not null
);


create table lekcje(
id_lekcji integer not null,
id_nauczyciela integer not null,	
id_klasy integer not null
);


alter table przedmiot
 add constraint id_przedmiotu_pk primary key ( id_przedmiotu);

alter table nauczyciel(
	add constraint Id_nauczyciela_pk primary key (id_nauczyciela),
	add constraint id_przedmiotu_fk foreign key (id_przedmiotu) references przedmiot (id_przedmiotu)

)
alter table klasa
 add constraint id_klasy_pk primary key (id_klasy);

 alter table uczen(
	add constraint Id_ucznia_pk primary key (id_ucznia),
	add constraint id_klasy_fk foreign key (id_klasy) references klasa (id_klasy)

)

  alter table oceny(
	add constraint id_oceny_pk primary key (id_oceny),
	add constraint id_oc_nauczyciela_fk foreign key (id_nauczyciela) references nauczyciel (id_nauczyciela),
	add constraint id_oc_uczen_fk foreign key (id_ucznia) references uczen (id_ucznia)
)

  alter table lekcje (
	add constraint id_lekcje_pk primary key (id_lekcji),
	add constraint id_li_nauczyciela_fk foreign key (id_nauczyciela) references nauczyciel (id_nauczyciela),
	add constraint id_li_klasa_fk foreign key (id_klasy) references uczen (id_klasy)
 )

  -----------------------------------------------------------------------------------------------------------