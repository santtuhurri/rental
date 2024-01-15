--Varauksen peruuttaminen Kotkan toimipisteessä (käytössä INSERT-lause kuluvalle päivälle, oikea varaustilanne)
--Varausta ei saa luoda vuokraukseksi, jos vuokraus on luotu aja nämä komennot:
--DELETE FROM VUOKRAAMINEN
--WHERE vuokra_id = 'VU00000015';
--DELETE FROM VUOKRAUS
--WHERE vuokra_id = 'VU00000015';
--DELETE FROM VARAAMINEN
--WHERE varaus_id = 'VA00000016';
--DELETE FROM VARAUS
--WHERE varaus_id = 'VA00000016';
--INSERT INTO VARAUS
--(varaus_id, asiakas_id, alkupvm, loppupvm)
--VALUES
--('VA00000016', 'A000000001', (SELECT CAST( GETDATE() AS Date)), (SELECT CAST( GETDATE() +7 AS Date))); 
--INSERT INTO VARAAMINEN
--(elokuva_id, varaus_id)
--VALUES
--('E00001', 'VA00000016');
--Nyt voit kokeilla varauksen peruuttamista
DELETE FROM VARAAMINEN
WHERE varaus_id = 'VA00000016';

DELETE FROM VARAUS
WHERE varaus_id = 'VA00000016';

UPDATE VALIKOIMA
SET maaravarastossa = maaravarastossa + 1
WHERE elokuva_id = 'E00001' AND toimipiste_id = 'TO001';

--Lunastamattomien varausten poistaminen “varattu” lokerosta, kun varauksen ajan-kohta on umpeutunut (käytössä INSERT-lause testitapausta varten, varaus vanhentunut 2022-12-12)
--Varausta ei saa luoda vuokraukseksi, jos vuokraus on luotu aja nämä komennot:
--DELETE FROM VUOKRAAMINEN
--WHERE vuokra_id = 'VU00000015';
--DELETE FROM VUOKRAUS
--WHERE vuokra_id = 'VU00000015';
--DELETE FROM VARAAMINEN
--WHERE varaus_id = 'VA00000016';
--DELETE FROM VARAUS
--WHERE varaus_id = 'VA00000016';
--INSERT INTO VARAUS
--(varaus_id, asiakas_id, alkupvm, loppupvm)
--VALUES
--('VA00000016', 'A000000001', '2022-12-05', '2022-12-12'); 
--INSERT INTO VARAAMINEN
--(elokuva_id, varaus_id)
--VALUES
--('E00001', 'VA00000016');
--Nyt voit kokeilla varauksen peruuttamista
DELETE VARAAMINEN
FROM VARAAMINEN v
LEFT JOIN VARAUS va ON va.varaus_id=v.varaus_id
LEFT JOIN VUOKRAUS vu ON vu.varaus_id=va.varaus_id
WHERE v.varaus_id = 'VA00000016' 
AND va.loppupvm < (SELECT CAST( GETDATE() AS Date))
AND v.varaus_id NOT IN (
SELECT varaus_id
FROM VUOKRAUS vu);

DELETE VARAUS
FROM VARAUS va
LEFT JOIN VARAAMINEN v ON v.varaus_id=va.varaus_id
LEFT JOIN VUOKRAUS vu ON vu.varaus_id=v.varaus_id
WHERE va.varaus_id = 'VA00000016' 
AND va.loppupvm < (SELECT CAST( GETDATE() AS Date))
AND va.varaus_id NOT IN (
SELECT varaus_id
FROM VUOKRAUS vu);

UPDATE VALIKOIMA
SET maaravarastossa = 
(case when elokuva_id = 'E00001' then maaravarastossa + 1
when elokuva_id = 'E00002' then maaravarastossa +1
end)
WHERE elokuva_id in ('E00001', 'E00002') AND
toimipiste_id = 'TO001';

--Asiakastietojen poistaminen
DELETE FROM ASIAKAS
WHERE asiakas_id = 'A000000010';
