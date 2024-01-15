--Mitä elokuvia kuuluu vakituiseen (normaalihintaiset) valikoimaan? 
SELECT nimi, tyyppi
FROM ELOKUVA 
WHERE tyyppi = 'Normaali'; 

--Mitkä elokuvat kuuluvat uutuuksiin? 
SELECT nimi, tyyppi
FROM ELOKUVA 
WHERE tyyppi = 'Uutuus'; 

--Mitä oheistuotteita on tarjolla? 
SELECT oh.nimi, oh.hinta, oh.kuvaus, va.oheistuotemaara 
FROM OHEISTUOTE oh 
JOIN VARASTO va ON va.tuote_id=oh.tuote_id 
WHERE oheistuotemaara IS NOT NULL 
ORDER BY oh.nimi; 

--Mitä oheistuotteita on tarjolla kussakin keskuksessa?
SELECT toi.nimi AS 'Toimipiste', oh.nimi, oh.hinta, oh.kuvaus, va.oheistuotemaara , va.toimipiste_id 
FROM OHEISTUOTE oh 
JOIN VARASTO va ON va.tuote_id=oh.tuote_id 
JOIN TOIMIPISTE toi ON toi.toimipiste_id=va.toimipiste_id
WHERE oheistuotemaara IS NOT NULL 
ORDER BY toi.nimi, oh.nimi; 

--Mikä on varauksen tehneen asiakkaan puhelinnumero? 
SELECT asi.puh 
FROM ASIAKAS asi 
JOIN VARAUS va ON va.asiakas_id=asi.asiakas_id 
WHERE varaus_id = 'VA00000001'; 

--Mikä on varauksen tehneen asiakkaan nimi sekä puhelinnumero?
SELECT asi.puh, asi.etunimi, asi.sukunimi
FROM ASIAKAS asi 
JOIN VARAUS va ON va.asiakas_id=asi.asiakas_id 
WHERE varaus_id = 'VA00000001'; 

--Kuinka monta varausta asiakkaalla on voimassa tällä hetkellä? 
SELECT asi.etunimi, asi.sukunimi, COUNT(va.varaus_id) AS 'Varausten lukumäärä'
FROM ASIAKAS asi 
JOIN VARAUS va ON va.asiakas_id=asi.asiakas_id 
WHERE loppupvm = (SELECT CAST( GETDATE() AS Date)) OR loppupvm > (SELECT CAST( GETDATE() AS date)) 
GROUP BY asi.etunimi, asi.sukunimi; 

--Mitä elokuvia asiakkailla on tällä hetkellä vuokralla?
SELECT asi.etunimi, asi.sukunimi, el.nimi AS 'Elokuvan nimi'
FROM ASIAKAS asi 
JOIN VARAUS va ON va.asiakas_id=asi.asiakas_id 
JOIN VARAAMINEN vara ON vara.varaus_id=va.varaus_id
JOIN ELOKUVA el ON el.elokuva_id=vara.elokuva_id
WHERE loppupvm = (SELECT CAST( GETDATE() AS Date)) OR loppupvm > (SELECT CAST( GETDATE() AS date)) 
GROUP BY asi.etunimi, asi.sukunimi, el.nimi; 

--Kuinka monta kertaa jotakin elokuvaa on vuokrattu kaiken kaikkiaan? 
SELECT el.nimi, COUNT(vu.vuokra_id) AS 'Vuokrausten kokonaismäärä'
FROM ELOKUVA el
JOIN VUOKRAAMINEN vu ON vu.elokuva_id=el.elokuva_id
GROUP BY el.nimi;

--Kuinka monta aktiivista varausta elokuvalla on kyseisellä hetkellä? 
SELECT el.nimi, COUNT(va.loppupvm) AS 'Aktiivisten varausten lukumäärä'
FROM ELOKUVA el
JOIN VARAAMINEN vara ON vara.elokuva_id=el.elokuva_id
JOIN VARAUS va ON va.varaus_id=vara.varaus_id
WHERE loppupvm > (SELECT CAST( GETDATE() AS date)) 
GROUP BY el.nimi;

--Kuinka monta kappaletta elokuvaa 'Black Adam' on varastossa kussakin keskuksessa? 
SELECT toi.nimi AS 'Toimipiste', el.nimi, va.maaravarastossa
FROM ELOKUVA el
JOIN VALIKOIMA va ON el.elokuva_id=va.elokuva_id
JOIN TOIMIPISTE toi ON toi.toimipiste_id=va.toimipiste_id
WHERE el.nimi = 'Black Adam'
ORDER BY toi.nimi, el.nimi;

--Ketkä työntekijät ovat olleet työvuorossa sunnuntaina 20.11.2022 ja missä toimipisteessä? 
SELECT toi.nimi AS 'Toimipiste', tt.tyontekija_id, tv.alku_aika, tv.loppu_aika
FROM TOIMIPISTE toi
JOIN TYOSKENTELY tyo ON tyo.toimipiste_id=toi.toimipiste_id
JOIN TYOVUORO tv ON tv.tyontekija_id=tyo.tyontekija_id
JOIN TYONTEKIJA tt ON tt.tyontekija_id=tv.tyontekija_id
WHERE tyovuoro_pvm = '2022-11-20';

--Listataan yhden asiakkaan kaikki tiedot
SELECT asi.asiakas_id, asi.etunimi, asi.sukunimi, asi.puh, asi.sposti, asi.katuosoite, asi.postinro, po.postitmp
FROM ASIAKAS asi
JOIN POSTITMP po ON po.postinro=asi.postinro
WHERE asiakas_id = 'A000000003';

--Työvuorolistojen tarkastelu Kotkan toimipisteessä
SELECT toi.nimi AS 'Toimipiste', tv.tyovuoro_pvm, tt.tyontekija_id, tv.alku_aika, tv.loppu_aika
FROM TOIMIPISTE toi
JOIN TYOSKENTELY tyo ON tyo.toimipiste_id=toi.toimipiste_id
JOIN TYOVUORO tv ON tv.tyontekija_id=tyo.tyontekija_id
JOIN TYONTEKIJA tt ON tt.tyontekija_id=tv.tyontekija_id
WHERE toi.nimi = 'Kotkan Vuokraamo X'
ORDER BY toi.nimi, tv.tyovuoro_pvm;
