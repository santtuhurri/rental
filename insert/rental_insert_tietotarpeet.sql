--Varauksen tekeminen Kotkan toimipisteessä
--Kuluvalle päivälle (oikea varaustilanne)
INSERT INTO VARAUS
(varaus_id, asiakas_id, alkupvm, loppupvm)
VALUES
('VA00000016', 'A000000001', (SELECT CAST( GETDATE() AS Date)), (SELECT CAST( GETDATE() +7 AS Date))); 

--Tietylle päivämäärälle testitapausta varten
INSERT INTO VARAUS
(varaus_id, asiakas_id, alkupvm, loppupvm)
VALUES
('VA00000016', 'A000000001', '2022-12-05', '2022-12-12'); 

INSERT INTO VARAAMINEN
(elokuva_id, varaus_id)
VALUES
('E00001', 'VA00000016');

UPDATE VALIKOIMA
SET maaravarastossa = maaravarastossa - 1
WHERE elokuva_id = 'E00001' AND toimipiste_id = 'TO001';

--Varauksen tuotemäärän muuttaminen (lisätään varaukseen toinen elokuva samana päivänä)
INSERT INTO VARAAMINEN
(elokuva_id, varaus_id)
VALUES
('E00002', 'VA00000016');

UPDATE VALIKOIMA
SET maaravarastossa = maaravarastossa - 1
WHERE elokuva_id = 'E00002' AND toimipiste_id = 'TO001';

--Varattujen tuotteiden kirjaaminen vuokratuiksi/myydyiksi
INSERT INTO VUOKRAUS
(vuokra_id, varaus_id, alkupvm, erapvm)
VALUES
('VU00000015', 'VA00000016', (SELECT CAST( GETDATE() AS Date)), (SELECT CAST( GETDATE() +7 AS Date))); 

INSERT INTO VUOKRAAMINEN
(elokuva_id, vuokra_id)
VALUES
('E00002', 'VU00000015'),
('E00001', 'VU00000015');

--Vuokrauksen tekeminen Kotkan vuokraamon tiskiltä, ilman aiempaa varausta
INSERT INTO VARAUS
(varaus_id, asiakas_id, alkupvm, loppupvm)
VALUES
('VA00000017', 'A000000005', (SELECT CAST( GETDATE() AS Date)), (SELECT CAST( GETDATE() +7 AS Date))); 

INSERT INTO VARAAMINEN
(elokuva_id, varaus_id)
VALUES
('E00006', 'VA00000017');

UPDATE VALIKOIMA
set maaravarastossa = maaravarastossa - 1
WHERE elokuva_id = 'E00006' AND toimipiste_id = 'TO001';

INSERT INTO VUOKRAUS
(vuokra_id, varaus_id, alkupvm, erapvm)
VALUES
('VU00000016', 'VA00000017', (SELECT CAST( GETDATE() AS Date)), (SELECT CAST( GETDATE() +7 AS Date))); 

INSERT INTO VUOKRAAMINEN
(elokuva_id, vuokra_id)
VALUES
('E00006', 'VU00000016');

--Asiakastietojen luominen
INSERT INTO ASIAKAS
(asiakas_id, etunimi, sukunimi, puh, sposti, katuosoite, postinro)
VALUES
('A000000010', 'Mauno', 'Asiakas', '+35841234777', 'mauno.asiakas@gmail.com', 'Tietokatu 15', '48100');
