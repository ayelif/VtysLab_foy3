CREATE DATABASE foy3;

--1.soru
CREATE TABLE birimler (
birim_id INT NOT NULL PRIMARY KEY,
birim_ad CHAR(25) NOT NULL
);

CREATE TABLE calisanlar(
calisan_id INT NOT NULL PRIMARY KEY,
ad CHAR(25) NULL,
soyad CHAR(25) NULL,
maas INT NULL,
katilmaTarihi DATETIME NULL,
calisan_birim_id INT NOT NULL,
FOREIGN KEY (calisan_birim_id) REFERENCES birimler(birim_id)
);

CREATE TABLE unvan (
unvan_calisan_id INT NOT NULL,
unvan_calisan CHAR(25) NULL,
unvan_tarih DATETIME NULL,
FOREIGN KEY (unvan_calisan_id) REFERENCES calisanlar(calisan_id) ON DELETE CASCADE
);

CREATE TABLE ikramiye (
ikramiye_calisan_id INT NOT NULL,
ikramiye_ucret INT NULL,
ikramiye_tarih DATETIME NULL,
FOREIGN KEY (ikramiye_calisan_id) REFERENCES calisanlar(calisan_id) ON DELETE CASCADE
);

--2. soru

INSERT INTO birimler (birim_id, birim_ad) VALUES
(1, 'Yazılım'),
(2, 'Donanım'),
(3, 'Güvenlik');

INSERT INTO calisanlar (calisan_id, ad, soyad, maas, katilmaTarihi, calisan_birim_id) VALUES
(1, 'İsmail', İşeri', 100000, '2014-02-20', 1),
(2, 'Hami', 'Satılmış', 80000, '2014-06-11', 1),
(3, 'Dumuş', 'Şahin', 300000, '2014-02-20', 2),
(4, 'Kağan', 'Yazar', 500000, '2014-02-20', 3),
(5, 'Meryem', 'Soysaldı', 500000, '2014-06-11', 3),
(6, 'Duygu', 'Akşehir', 200000, '2014-02-20', 2),
(7, 'Kübra', 'Seyhan', 75000, '2014-01-01', 1),
(8, 'Gülcan', 'Yıldız', 90000, '2014-04-11', 3);


INSERT INTO unvan (unvan_calisan_id, unvan_calisan, unvan_tarih) VALUES
(1, 'Yönetici', '2016-02-20'),
(2, 'Personel', '2016-06-11'),
(8, 'Personel', '2016-06-11'),
(5, 'Müdür', '2016-06-11'),
(4, 'Yönetici Yardımcısı', '2016-06-11'),
(7, 'Personel', '2016-06-11' ),
(6, 'Takım Lideri', '2016-06-11' ),
(3, 'Takım Lideri', '2016-06-11');

INSERT INTO ikramiye (ikramiye_calisan_id, ikramiye_ucret, ikramiye_tarih) VALUES
(1, 5000, '2016-02-20' ),
(2, 3000, '2016-06-11' ),
(3, 4000, '2016-02-20' ),
(1, 4500, '2016-02-20' ),
(2, 3500, '2016-06-11' )


--3.soru

SELECT c.ad, c.soyad, c.maas
FROM calisanlar c
JOIN birimler b ON c.calisan_birim_id = b.birim_id
WHERE b.birim_ad = 'Yazılım' OR b.birim_ad = 'Donanım';

--4. soru

SELECT ad, soyad, maas
FROM calisanlar
WHERE maas = (SELECT MAX(maas) FROM calisanlar);

--5.soru

SELECT birimler.birim_ad, COUNT(calisanlar.calisan_id) AS calisan_sayisi
FROM birimler
LEFT JOIN calisanlar ON birimler.birim_id = calisanlar.calisan_birim_id
GROUP BY birimler.birim_ad;

--6.soru

SELECT unvan_calisan, COUNT(unvan_calisan_id) AS calisan_sayisi
FROM unvan
GROUP BY unvan_calisan
HAVING COUNT(unvan_calisan_id) > 1;

--7.soru

SELECT ad, soyad, maas
FROM calisanlar
WHERE maas BETWEEN 50000 AND 100000;

--8.soru

SELECT c.ad, c.soyad, b.birim_ad, u.unvan_calisan, i. ikramiye_ucret
FROM calisanlar c
JOIN birimler b ON c.calisan_birim_id = b.birim_id
JOIN unvan u ON c.calisan_id = u.unvan_calisan_id
JOIN ikramiye i ON c.calisan_id = i.ikramiye_calisan_id;

--9.soru

SELECT c.ad, c.soyad, u.unvan_calisan
FROM unvan u
JOIN calisanlar c ON u.unvan_calisan_id = c.calisan_id
WHERE u.unvan_calisan IN ('Yonetici', 'Mudür');

--10.soru

SELECT c.ad, c.soyad, c.maas, c.calisan_birim_id
FROM calisanlar c
WHERE c.maas = (
SELECT MAX(maas)
FROM calisanlar
WHERE calisan_birim_id = c.calisan_birim_id
);
