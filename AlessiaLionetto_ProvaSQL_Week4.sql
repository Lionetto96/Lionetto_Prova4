create database NegozioDischi;

create table Band(
IdBand int not null primary key identity(1,1),
Nome varchar(50) not null,
NumeroComponenti int not null)

create table Brano(
IdBrano int not null primary key identity(1,1),
Titolo varchar(50) not null,
Durata int not null)

create table Album(
IdAlbum int not null primary key identity(1,1),
Titolo varchar(30)not null ,
AnnoDiUscita int not null,
CasaDiscografica varchar(50) not null,
Genere varchar(30) not null ,
Supporto varchar(30) not null ,
Idband int not null,
constraint UC_ALBUM unique(Titolo,AnnoDiUscita,CasaDiscografica,Genere,Supporto),
constraint FK_1 foreign key (IdBand) references  Band(IdBand))

create table AlbumBrano(
IdAlbum int,
IdBrano int,
constraint PK_ALBUMBRANO primary key (IdAlbum,IdBrano),
constraint FK_2 foreign key (IdAlbum) references Album(IdAlbum),
constraint FK_3 foreign key (IdBrano) references Brano(IdBrano))


--1) Scrivere una query che restituisca i titoli degli album degli “883” in ordine alfabetico;
--2) Selezionare tutti gli album della casa discografica “Sony Music” relativi all’anno 2020;
--3) Scrivere una query che restituisca tutti i titoli delle canzoni dei “Maneskin” appartenenti 
--ad album pubblicati prima del 2019;
--4) Individuare tutti gli album in cui è contenuta la canzone “Imagine”;
--5) Restituire il numero totale di canzoni eseguite dalla band “The Giornalisti”;
--6) Contare per ogni album, la “durata totale” cioè la somma dei secondi dei suoi brani
--7) Mostrare i brani (distinti) degli “883” che durano più di 3 minuti (in alternativa usare i 
--secondi quindi 180 s).
--8) Mostrare tutte le Band il cui nome inizia per “M” e finisce per “n”.
--9) Mostrare il titolo dell’Album e di fianco un’etichetta che stabilisce che si tratta di un
--Album:
--‘Very Old’ se il suo anno di uscita è precedente al 1980, 
--‘New Entry’ se l’anno di uscita è il 2021,
--‘Recente’ se il suo anno di uscita è compreso tra il 2010 e 2020, 
--‘Old’ altrimenti.
--10) Mostrare i brani non contenuti in nessun album.

select * from Band
select * from Album
select * from Brano
select * from AlbumBrano
--1
insert into Band values('883',2)
insert into Album values('Nord Sud Ovest Est',1993,'Sony','pop','cd',1)
insert into Album values('Hanno ucciso l''uomo ragno',1992,'Aris','rock','vinile',1)

select a.Titolo as TitoloAlbum
from Album a
join Band b on b.IdBand=a.Idband
where b.Nome='883'
order by a.Titolo
--2
insert into Band values('Pinguini tattici',3)
insert into Album values('Ahia!',2020,'Sony','pop','cd',2)

select *
from Album a
where a.AnnoDiUscita=2020 and a.CasaDiscografica='Sony'
--3
insert into Band values('Maneskin',4)
insert into Album values('il ballo della vita',2018,'Sony','rock','cd',3)
insert into Brano values ('new song',150)
insert into Brano values ('torna a casa',170)
insert into Brano values ('l''altra dimensione',165)
insert into Brano values ('le parole lontane',138)
insert into AlbumBrano values (4,1)
insert into AlbumBrano values (4,2)
insert into AlbumBrano values (4,3)
insert into AlbumBrano values (4,4)
insert into Album values('Chosen',2018,'Sony','rock','cd',3)
insert into Brano values ('chosen',181)
insert into Brano values ('recovery',183)
insert into Brano values ('vengo dalla luna',165)
insert into Brano values ('somebody told me',138)
insert into AlbumBrano values (5,5)
insert into AlbumBrano values (5,6)
insert into AlbumBrano values (5,7)
insert into AlbumBrano values (5,8)

select b.Titolo
from Brano b
join AlbumBrano ab on ab.IdBrano=b.IdBrano
join Album a on a.IdAlbum=ab.IdAlbum
join Band bb on bb.IdBand=a.Idband
where bb.Nome='Maneskin' and a.AnnoDiUscita<2019

--4
insert into Brano values ('Imagine',180)
insert into Band values('John Lennon',1)
insert into Album values ('Imagine',1971,'apple records','pop','vinile',4)
insert into AlbumBrano values(6,9)
insert into AlbumBrano values(5,9)


select a.Titolo
from Album a
join AlbumBrano ab on ab.IdAlbum=a.IdAlbum
join Brano b on b.IdBrano=ab.IdBrano
where b.Titolo='Imagine'
--5
insert into Brano values ('riccione',190)
insert into Brano values ('questa nostra stupida canzone d''amore',155)
insert into Brano values ('new york',155)
insert into Band values('Thegiornalisti',3)
insert into Album values ('Love',2018,'apple records','pop','streaming',5)
insert into Album values ('Completamente',2016,'apple records','pop','streaming',5)
insert into AlbumBrano values(7,11)
insert into AlbumBrano values(7,12)
insert into AlbumBrano values(8,10)

select  count(b.IdBrano) as canzoniEseguiteDaTheGiornalisti
from Brano b 
join AlbumBrano ab on ab.IdBrano=b.IdBrano
join Album a on a.IdAlbum=ab.IdAlbum
join Band bb on bb.IdBand=a.Idband
where bb.Nome='Thegiornalisti'

--6
select a.Titolo, sum(b.Durata) as durataTotaleALbum
from Brano b
join AlbumBrano ab on ab.IdBrano=b.IdBrano
join Album a on a.IdAlbum=ab.IdAlbum
group by a.Titolo

--7
insert into Brano values('sei un mito',185)
insert into Brano values('il pappagallo', 199)
insert into Brano values ('non me la menare',179)
insert into AlbumBrano values (1,13)
insert into AlbumBrano values (1,14)
insert into AlbumBrano values (2,15)

select distinct b.Titolo as titoloCanzone883,b.Durata as durataSupAi3min
from Brano b 
join AlbumBrano ab on ab.IdBrano=b.IdBrano
join Album a on a.IdAlbum=ab.IdAlbum
join Band bb on bb.IdBand=a.Idband
where bb.Nome='883' and b.Durata>180

--8
select *
from Band b 
where b.Nome like 'M%n'

--9

insert into Album values('Teatro d''ira',2021,'Sony','rock','streaming',3)

select a.Titolo,
case
	 when  a.AnnoDiUscita<1980  then 'Very Old'
	 when  a.AnnoDiUscita=2021 then 'New Entry'
	 when  a.AnnoDiUscita between 2010 and 2020 then 'Recente'
	 else 'Old'
end as ClassificaAlbum
from Album a

--10 
insert into Brano values('zitti e buoni',158)
insert into Brano values('coraline',171)

select b.Titolo
from Brano b 
left join AlbumBrano ab on ab.IdBrano=b.IdBrano
where ab.IdAlbum is null 

--DOMANDE TEORICHE 
--1: B
--2: CON LA CREAZIONE DI UNA TERZA TABELLA CHE INCLUDE GLI ID DELLE 2 TABELLE 
--3:B
--4:B
--5: B
