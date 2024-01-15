--Tietokannan taulujen luonti oikeassa järjestyksessä huomioiden PK:t ja FK:t
CREATE TABLE POSTITMP( 
postinro char(5) NOT NULL, 
postitmp varchar(30) NOT NULL, 
PRIMARY KEY(postinro), 
); 

CREATE TABLE ELOKUVA( 
elokuva_id char(6) NOT NULL, 
tyyppi varchar(10), 
nimi varchar(40) NOT NULL, 
hinta decimal(3,2), 
julkaisuvuosi int, 
kesto int, 
PRIMARY KEY(elokuva_id), 
); 

CREATE TABLE OHEISTUOTE( 
tuote_id char(5) NOT NULL, 
nimi varchar(20) NOT NULL, 
hinta decimal(5,2), 
kuvaus varchar(40), 
PRIMARY KEY(tuote_id), 
); 

CREATE TABLE TYONTEKIJA( 
tyontekija_id char(5) NOT NULL, 
rooli varchar(40), 
PRIMARY KEY(tyontekija_id), 
); 

CREATE TABLE TOIMIPISTE( 
toimipiste_id char(5) NOT NULL, 
nimi varchar(30), 
katuosoite varchar(40), 
postinro char(5), 
puhelinnumero char(13), 
sposti varchar(40), 
PRIMARY KEY(toimipiste_id), 
FOREIGN KEY(postinro) REFERENCES POSTITMP(postinro) 
); 

CREATE TABLE ASIAKAS( 
asiakas_id char(10) NOT NULL, 
etunimi varchar(20) NOT NULL, 
sukunimi varchar(30) NOT NULL, 
puh char(13) NOT NULL, 
sposti varchar(40) NOT NULL, 
katuosoite varchar(40) NOT NULL, 
postinro char(5) NOT NULL, 
PRIMARY KEY(asiakas_id), 
FOREIGN KEY(postinro) REFERENCES POSTITMP(postinro) 
); 

CREATE TABLE TYOVUORO( 
tyovuoro_id char(10) NOT NULL, 
tyontekija_id char(5), 
tyovuoro_pvm date NOT NULL, 
alku_aika time NOT NULL, 
loppu_aika time NOT NULL, 
PRIMARY KEY(tyovuoro_id), 
FOREIGN KEY(tyontekija_id) REFERENCES TYONTEKIJA(tyontekija_id) 
); 

CREATE TABLE VARAUS( 
varaus_id char(10) NOT NULL, 
asiakas_id char(10) NOT NULL, 
alkupvm date NOT NULL, 
loppupvm date NOT NULL, 
PRIMARY KEY(varaus_id), 
FOREIGN KEY(asiakas_id) REFERENCES ASIAKAS(asiakas_id) 
); 

CREATE TABLE VUOKRAUS( 
vuokra_id char(10) NOT NULL, 
varaus_id char(10) NOT NULL, 
alkupvm date NOT NULL, 
erapvm date NOT NULL, 
PRIMARY KEY(vuokra_id), 
FOREIGN KEY(varaus_id) REFERENCES VARAUS(varaus_id) 
); 

CREATE TABLE VARASTO( 
tuote_id char(5) NOT NULL, 
toimipiste_id char(5) NOT NULL, 
oheistuotemaara integer, 
PRIMARY KEY(tuote_id, toimipiste_id), 
FOREIGN KEY(tuote_id) REFERENCES OHEISTUOTE(tuote_id), 
FOREIGN KEY(toimipiste_id) REFERENCES TOIMIPISTE(toimipiste_id) 
); 

CREATE TABLE VALIKOIMA( 
elokuva_id char(6) NOT NULL, 
toimipiste_id char(5) NOT NULL, 
maaravarastossa int, 
PRIMARY KEY(elokuva_id, toimipiste_id), 
FOREIGN KEY(elokuva_id) REFERENCES ELOKUVA(elokuva_id), 
FOREIGN KEY(toimipiste_id) REFERENCES TOIMIPISTE(toimipiste_id) 
); 

CREATE TABLE VARAAMINEN( 
elokuva_id char(6) NOT NULL, 
varaus_id char(10) NOT NULL, 
PRIMARY KEY(elokuva_id, varaus_id), 
FOREIGN KEY(elokuva_id) REFERENCES ELOKUVA(elokuva_id), 
FOREIGN KEY(varaus_id) REFERENCES VARAUS(varaus_id) 
); 

CREATE TABLE VUOKRAAMINEN( 
elokuva_id char(6) NOT NULL, 
vuokra_id char(10) NOT NULL, 
PRIMARY KEY(elokuva_id, vuokra_id), 
FOREIGN KEY(elokuva_id) REFERENCES ELOKUVA(elokuva_id), 
FOREIGN KEY(vuokra_id) REFERENCES VUOKRAUS(vuokra_id) 
); 

CREATE TABLE TYOSKENTELY( 
tyontekija_id char(5) NOT NULL, 
toimipiste_id char(5) NOT NULL, 
PRIMARY KEY(tyontekija_id, toimipiste_id), 
FOREIGN KEY(tyontekija_id) REFERENCES TYONTEKIJA(tyontekija_id), 
FOREIGN KEY(toimipiste_id) REFERENCES TOIMIPISTE(toimipiste_id) 
); 

CREATE TABLE ASIOINTI( 
asiakas_id char(10) NOT NULL, 
toimipiste_id char(5) NOT NULL, 
PRIMARY KEY(asiakas_id, toimipiste_id), 
FOREIGN KEY(asiakas_id) REFERENCES ASIAKAS(asiakas_id), 
FOREIGN KEY(toimipiste_id) REFERENCES TOIMIPISTE(toimipiste_id) 
); 
