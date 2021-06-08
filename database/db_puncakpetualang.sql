-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 08 Jun 2021 pada 01.56
-- Versi server: 10.4.17-MariaDB
-- Versi PHP: 8.0.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_puncakpetualang`
--

DELIMITER $$
--
-- Prosedur
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `pengembalian` (IN `nomor_pengembalian` INT(11), IN `nomor_admin` INT(11), IN `nomor_barang` INT(11), IN `nomor_customer` INT(11), IN `nomor_sewa` INT(11), IN `vtanggal_kembali` DATE, IN `vketerangan` VARCHAR(1000), IN `durasilama_sewa` INT(11), IN `jumlahbiaya_sewa` INT(11), IN `totaldenda` INT(11), IN `jumlahtotal_pembayaran` INT(12), IN `vketerangan_bayar` VARCHAR(25))  BEGIN

	INSERT INTO pengembalian VALUES (NULL, nomor_admin, nomor_barang, nomor_customer, nomor_sewa, vtanggal_kembali, vketerangan, durasilama_sewa, jumlahbiaya_sewa, totaldenda, jumlahtotal_pembayaran, vketerangan_bayar);

	DELETE FROM penyewaan WHERE id_sewa = nomor_sewa;

	UPDATE mobil SET keterangan = 'tersedia' WHERE id_barang = nomor_barang;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `penyewaan` (IN `no_admin` VARCHAR(10), IN `no_barang` VARCHAR(10), IN `no_customer` VARCHAR(10), IN `vtanggalsewa` DATE, IN `vwaktusewa` VARCHAR(10))  BEGIN 
	UPDATE barang SET keterangan='tidak tersedia' 		WHERE id_barang = no_barang;
    INSERT INTO `penyewaan` (`id_admin`, `id_barang`, `id_customer`, `tanggal_sewa`, `waktu_sewa`) 
    VALUES (no_admin,no_barang, vidcustomer, vtanggalsewa, vwaktusewa);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `tambah_barang` (IN `vidbarang` INT(11), IN `jenisbarang` VARCHAR(100), IN `namabarang` VARCHAR(100), IN `vhargasewa` INT(11), IN `vketerangan` VARCHAR(100))  BEGIN 
INSERT INTO `barang`(`id_barang`, `jenis_barang`, `nama_barang`, `harga_sewa`, `keterangan`)
VALUES (vidbarang,jenisbarang,namabarang,vhargasewa,vketerangan);
END$$

--
-- Fungsi
--
CREATE DEFINER=`root`@`localhost` FUNCTION `lihatbarang` (`barang` INT) RETURNS INT(11) BEGIN
DECLARE jml INT;
SELECT COUNT(*) AS jml_barang INTO jml FROM pengembalian WHERE id_barang = barang;
RETURN jml;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `admin`
--

CREATE TABLE `admin` (
  `id_admin` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `id_status` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `admin`
--

INSERT INTO `admin` (`id_admin`, `username`, `password`, `nama`, `id_status`) VALUES
(1, 'admin1', 'adminke1', 'Fauziah Reza Oktaviyani', 1),
(2, 'admin2', 'adminke2', 'Almarus Salsa Beila Suryanto', 2),
(3, 'admin3', 'adminke3', 'Nanda Prabu Angganata', 2),
(4, 'admin4', 'adminke4', 'M. Erwin Prima Arya', 2),
(5, 'admin5', 'adminke5', 'Khozainul Asros', 2);

-- --------------------------------------------------------

--
-- Struktur dari tabel `barang`
--

CREATE TABLE `barang` (
  `id_barang` int(11) NOT NULL,
  `jenis_barang` varchar(50) NOT NULL,
  `nama_barang` varchar(255) NOT NULL,
  `harga_sewa` int(15) NOT NULL,
  `keterangan` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `barang`
--

INSERT INTO `barang` (`id_barang`, `jenis_barang`, `nama_barang`, `harga_sewa`, `keterangan`) VALUES
(1, 'Tas', 'ARei Carrier Toba', 50000, 'tersedia'),
(2, 'Sepatu', 'Eiger Boots Pollock', 25000, 'tersedia'),
(3, 'Tenda', 'Eiger Riding Explorer', 150000, 'tersedia'),
(4, 'Peralatan Masak', 'Cooking Set', 15000, 'tersedia'),
(5, 'Tas', 'Eiger Eliptic Solaris', 45000, 'tersedia'),
(6, 'Tas', 'Osprey Kestrel', 35000, 'tersedia'),
(7, 'Sepatu', 'Adidas Terrex Swift R2', 30000, 'tersedia'),
(8, 'Tenda', 'Consina Magnum 5 productnation', 140000, 'tersedia'),
(9, 'Sepatu', 'The North Face Chilkat 400', 35000, 'tersedia'),
(10, 'Sepatu', 'Columbia Fairbanks', 30000, 'tersedia');

--
-- Trigger `barang`
--
DELIMITER $$
CREATE TRIGGER `update_harga` BEFORE UPDATE ON `barang` FOR EACH ROW BEGIN
    INSERT INTO log_data_barang
    set id_barang = OLD.id_barang,
    harga_baru=new.harga_sewa,
    harga_lama=old.harga_sewa,
    waktu_perubahan = NOW(); 
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `barang_sedang_dipinjam`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `barang_sedang_dipinjam` (
`COUNT(id_sewa)` bigint(21)
);

-- --------------------------------------------------------

--
-- Struktur dari tabel `customer`
--

CREATE TABLE `customer` (
  `id_customer` int(11) NOT NULL,
  `nama` varchar(255) NOT NULL,
  `no_wa` varchar(255) NOT NULL,
  `alamat` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `customer`
--

INSERT INTO `customer` (`id_customer`, `nama`, `no_wa`, `alamat`) VALUES
(1, 'Justin Prabu', '81234567892', 'Sidoarjo'),
(2, 'Kai Havertz', '82257176189', 'Maluku'),
(3, 'Crishtian Pulisic', '87887667616', 'Lamongan'),
(4, 'Eduo Mendy', '3156674117', 'Ambon'),
(5, 'Thomas Tuchel', '83834712821', 'Bangkalan'),
(6, 'Mason Mount', '812345678903', 'Gresik'),
(7, 'Hakim Ziyech', '81098765432', 'Mojokerto');

-- --------------------------------------------------------

--
-- Struktur dari tabel `level_user`
--

CREATE TABLE `level_user` (
  `id_status` int(10) NOT NULL,
  `status_level` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `level_user`
--

INSERT INTO `level_user` (`id_status`, `status_level`) VALUES
(1, 'Superadmin'),
(2, 'admin');

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `list_barang`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `list_barang` (
`id_barang` int(11)
,`jenis_barang` varchar(50)
,`nama_barang` varchar(255)
,`harga_sewa` int(15)
,`keterangan` varchar(255)
);

-- --------------------------------------------------------

--
-- Struktur dari tabel `log_data_barang`
--

CREATE TABLE `log_data_barang` (
  `id_log_barang` int(11) NOT NULL,
  `id_barang` int(11) NOT NULL,
  `harga_lama` int(11) NOT NULL,
  `harga_baru` int(11) NOT NULL,
  `waktu_perubahan` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `mobil_ready`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `mobil_ready` (
`COUNT(id_barang)` bigint(21)
);

-- --------------------------------------------------------

--
-- Struktur dari tabel `pengembalian`
--

CREATE TABLE `pengembalian` (
  `id_pengembalian` int(11) NOT NULL,
  `id_admin` int(11) NOT NULL,
  `id_barang` int(11) NOT NULL,
  `id_customer` int(11) NOT NULL,
  `id_sewa` int(11) NOT NULL,
  `tanggal_kembali` date NOT NULL,
  `keterangan` varchar(255) NOT NULL,
  `lama_sewa` int(11) NOT NULL,
  `biaya_sewa` int(11) NOT NULL,
  `denda` int(11) NOT NULL,
  `total_pembayaran` int(20) NOT NULL,
  `keterangan_bayar` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktur dari tabel `penyewaan`
--

CREATE TABLE `penyewaan` (
  `id_sewa` int(11) NOT NULL,
  `id_admin` int(11) NOT NULL,
  `id_barang` int(11) NOT NULL,
  `id_customer` int(11) NOT NULL,
  `tanggal_sewa` date NOT NULL,
  `waktu_sewa` int(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktur untuk view `barang_sedang_dipinjam`
--
DROP TABLE IF EXISTS `barang_sedang_dipinjam`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `barang_sedang_dipinjam`  AS SELECT count(`penyewaan`.`id_sewa`) AS `COUNT(id_sewa)` FROM `penyewaan` ;

-- --------------------------------------------------------

--
-- Struktur untuk view `list_barang`
--
DROP TABLE IF EXISTS `list_barang`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `list_barang`  AS SELECT `barang`.`id_barang` AS `id_barang`, `barang`.`jenis_barang` AS `jenis_barang`, `barang`.`nama_barang` AS `nama_barang`, `barang`.`harga_sewa` AS `harga_sewa`, `barang`.`keterangan` AS `keterangan` FROM `barang` WHERE `barang`.`keterangan` in (select `barang`.`keterangan` from DUAL where `barang`.`keterangan` = 'tersedia') ;

-- --------------------------------------------------------

--
-- Struktur untuk view `mobil_ready`
--
DROP TABLE IF EXISTS `mobil_ready`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `mobil_ready`  AS SELECT count(`barang`.`id_barang`) AS `COUNT(id_barang)` FROM `barang` WHERE `barang`.`keterangan` = 'tersedia' ;

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`id_admin`),
  ADD KEY `id_status` (`id_status`);

--
-- Indeks untuk tabel `barang`
--
ALTER TABLE `barang`
  ADD PRIMARY KEY (`id_barang`);

--
-- Indeks untuk tabel `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`id_customer`);

--
-- Indeks untuk tabel `level_user`
--
ALTER TABLE `level_user`
  ADD PRIMARY KEY (`id_status`);

--
-- Indeks untuk tabel `log_data_barang`
--
ALTER TABLE `log_data_barang`
  ADD PRIMARY KEY (`id_log_barang`);

--
-- Indeks untuk tabel `pengembalian`
--
ALTER TABLE `pengembalian`
  ADD PRIMARY KEY (`id_pengembalian`),
  ADD KEY `id_admin` (`id_admin`),
  ADD KEY `id_barang` (`id_barang`),
  ADD KEY `id_customer` (`id_customer`),
  ADD KEY `id_sewa` (`id_sewa`);

--
-- Indeks untuk tabel `penyewaan`
--
ALTER TABLE `penyewaan`
  ADD PRIMARY KEY (`id_sewa`),
  ADD KEY `id_admin` (`id_admin`),
  ADD KEY `id_barang` (`id_barang`),
  ADD KEY `id_customer` (`id_customer`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `admin`
--
ALTER TABLE `admin`
  MODIFY `id_admin` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT untuk tabel `barang`
--
ALTER TABLE `barang`
  MODIFY `id_barang` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT untuk tabel `customer`
--
ALTER TABLE `customer`
  MODIFY `id_customer` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT untuk tabel `log_data_barang`
--
ALTER TABLE `log_data_barang`
  MODIFY `id_log_barang` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT untuk tabel `pengembalian`
--
ALTER TABLE `pengembalian`
  MODIFY `id_pengembalian` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT untuk tabel `penyewaan`
--
ALTER TABLE `penyewaan`
  MODIFY `id_sewa` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `admin`
--
ALTER TABLE `admin`
  ADD CONSTRAINT `admin_ibfk_1` FOREIGN KEY (`id_status`) REFERENCES `level_user` (`id_status`);

--
-- Ketidakleluasaan untuk tabel `pengembalian`
--
ALTER TABLE `pengembalian`
  ADD CONSTRAINT `pengembalian_ibfk_1` FOREIGN KEY (`id_admin`) REFERENCES `admin` (`id_admin`),
  ADD CONSTRAINT `pengembalian_ibfk_2` FOREIGN KEY (`id_barang`) REFERENCES `barang` (`id_barang`),
  ADD CONSTRAINT `pengembalian_ibfk_3` FOREIGN KEY (`id_customer`) REFERENCES `customer` (`id_customer`);

--
-- Ketidakleluasaan untuk tabel `penyewaan`
--
ALTER TABLE `penyewaan`
  ADD CONSTRAINT `penyewaan_ibfk_1` FOREIGN KEY (`id_admin`) REFERENCES `admin` (`id_admin`),
  ADD CONSTRAINT `penyewaan_ibfk_2` FOREIGN KEY (`id_barang`) REFERENCES `barang` (`id_barang`),
  ADD CONSTRAINT `penyewaan_ibfk_3` FOREIGN KEY (`id_customer`) REFERENCES `customer` (`id_customer`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
