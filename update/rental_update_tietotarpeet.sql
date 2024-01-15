--Asiakastietojen päivitys
UPDATE ASIAKAS
SET katuosoite = 'Asiakaskuja 13'
WHERE asiakas_id = 'A000000001';

--Elokuvan päivitys uutuudesta normaaliksi (kaikkialla samat tiedot elokuville)
UPDATE ELOKUVA
set tyyppi = 'Normaali'
WHERE elokuva_id = 'E00005';

--Oheistuotteen hinnan päivitys (kaikkialla samat tiedot oheistuotteille)
UPDATE OHEISTUOTE
set hinta = 5
WHERE tuote_id = 'O0001';

--Toimipisteen puhelinnumeron päivitys
UPDATE TOIMIPISTE
set puhelinnumero = '+358044987654'
WHERE toimipiste_id = 'TO001';

--Tyontekijän roolin päivittäminen
UPDATE TYONTEKIJA
set rooli = 'Esihenkilo'
WHERE tyontekija_id = 'TY001';

--Työvuoron keston päivittäminen
UPDATE TYOVUORO
set loppu_aika = '16:00:00'
WHERE tyovuoro_id = 'TV00000001';

--Elokuvan määrän päivittäminen valikoimassa Kotkan toimipisteen valikoimassa
UPDATE VALIKOIMA
set maaravarastossa = maaravarastossa - 1
WHERE elokuva_id = 'E00001' AND toimipiste_id = 'TO001';

--Oheistuotteen määrän päivittäminen Kotkan toimipisteen varastossa (tapahtuu myös myynnin yhteydessä)
UPDATE VARASTO
set oheistuotemaara = oheistuotemaara - 1
WHERE tuote_id = 'O0001' AND toimipiste_id = 'TO001';

--Asiakastietojen muokkaus 
UPDATE ASIAKAS
SET sposti = 'asiakas.mauno@gmail.com'
WHERE asiakas_id = 'A000000010';
