-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 08, 2021 at 04:11 PM
-- Server version: 10.4.11-MariaDB
-- PHP Version: 7.2.30

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
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `pengembalian` (IN `nomor_pengembalian` INT(11), IN `nomor_admin` INT(11), IN `nomor_barang` INT(11), IN `nomor_customer` INT(11), IN `nomor_sewa` INT(11), IN `vtanggal_kembali` DATE, IN `vketerangan` VARCHAR(1000), IN `durasilama_sewa` INT(11), IN `jumlahbiaya_sewa` INT(11), IN `totaldenda` INT(11), IN `jumlahtotal_pembayaran` INT(12), IN `vketerangan_bayar` VARCHAR(25))  BEGIN

	INSERT INTO pengembalian VALUES (NULL, nomor_admin, nomor_barang, nomor_customer, nomor_sewa, vtanggal_kembali, vketerangan, durasilama_sewa, jumlahbiaya_sewa, totaldenda, jumlahtotal_pembayaran, vketerangan_bayar);

	DELETE FROM penyewaan WHERE id_sewa = nomor_sewa;

	UPDATE mobil SET keterangan = 'tersedia' WHERE id_barang = nomor_barang;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `penyewaan` (IN `no_admin` VARCHAR(10), IN `no_barang` VARCHAR(10), IN `no_customer` VARCHAR(10), IN `vtanggalsewa` DATE, IN `vwaktusewa` VARCHAR(10))  BEGIN 
	UPDATE barang SET keterangan='tidak tersedia' 		WHERE id_barang = no_barang;
    INSERT INTO `penyewaan` (`id_admin`, `id_barang`, `id_customer`, `tanggal_sewa`, `waktu_sewa`)
    VALUES (no_admin,no_barang, no_customer, vtanggalsewa, vwaktusewa);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `tambah_barang` (IN `vidbarang` INT(11), IN `jenisbarang` VARCHAR(100), IN `namabarang` VARCHAR(100), IN `vhargasewa` INT(11), IN `vketerangan` VARCHAR(100))  BEGIN 
INSERT INTO `barang`(`id_barang`, `jenis_barang`, `nama_barang`, `harga_sewa`, `keterangan`)
VALUES (vidbarang,jenisbarang,namabarang,vhargasewa,vketerangan);
END$$

--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `lihatbarang` (`barang` INT) RETURNS INT(11) BEGIN
DECLARE jml INT;
SELECT COUNT(*) AS jml_barang INTO jml FROM pengembalian WHERE id_barang = barang;
RETURN jml;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `id_admin` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `id_status` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`id_admin`, `username`, `password`, `nama`, `id_status`) VALUES
(1, 'admin1', 'adminke1', 'Fauziah Reza Oktaviyani', 1),
(2, 'admin2', 'adminke2', 'Almarus Salsa Beila Suryanto', 2),
(3, 'admin3', 'adminke3', 'Nanda Prabu Angganata', 2),
(4, 'admin4', 'adminke4', 'M. Erwin Prima Arya', 2),
(5, 'admin5', 'adminke5', 'Khozainul Asros', 2);

-- --------------------------------------------------------

--
-- Table structure for table `barang`
--

CREATE TABLE `barang` (
  `id_barang` int(11) NOT NULL,
  `jenis_barang` varchar(50) NOT NULL,
  `nama_barang` varchar(255) NOT NULL,
  `harga_sewa` int(15) NOT NULL,
  `keterangan` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `barang`
--

INSERT INTO `barang` (`id_barang`, `jenis_barang`, `nama_barang`, `harga_sewa`, `keterangan`) VALUES
(1, 'Tas', 'ARei Carrier Toba', 50000, 'tersedia'),
(2, 'Sepatu', 'Eiger Boots Pollock', 25000, 'tersedia'),
(3, 'Tenda', 'Eiger Riding Explorer', 150000, 'tidak tersedia'),
(4, 'Peralatan Masak', 'Cooking Set', 15000, 'tersedia'),
(5, 'Tas', 'Eiger Eliptic Solaris', 45000, 'tidak tersedia'),
(6, 'Tas', 'Osprey Kestrel', 35000, 'tersedia'),
(7, 'Sepatu', 'Adidas Terrex Swift R2', 30000, 'tidak tersedia'),
(8, 'Tenda', 'Consina Magnum 5 productnation', 140000, 'tersedia'),
(9, 'Sepatu', 'The North Face Chilkat 400', 35000, 'tersedia'),
(10, 'Sepatu', 'Columbia Fairbanks', 30000, 'tersedia'),
(22, 'Tas', 'Bags', 2000, 'robet');

--
-- Triggers `barang`
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
-- Stand-in structure for view `barang_ready`
-- (See below for the actual view)
--
CREATE TABLE `barang_ready` (
`COUNT(id_barang)` bigint(21)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `barang_sedang_dipinjam`
-- (See below for the actual view)
--
CREATE TABLE `barang_sedang_dipinjam` (
`COUNT(id_sewa)` bigint(21)
);

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `id_customer` int(11) NOT NULL,
  `nama` varchar(255) NOT NULL,
  `no_wa` varchar(255) NOT NULL,
  `alamat` varchar(255) NOT NULL,
  `tanggal_lahir` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`id_customer`, `nama`, `no_wa`, `alamat`, `tanggal_lahir`) VALUES
(1, 'Justin Prabu', '81234567892', 'Sidoarjo', ''),
(2, 'Kai Havertz', '82257176189', 'Maluku', ''),
(3, 'Crishtian Pulisic', '87887667616', 'Lamongan', ''),
(4, 'Eduo Mendy', '3156674117', 'Ambon', ''),
(5, 'Thomas Tuchel', '83834712821', 'Bangkalan', ''),
(6, 'Mason Mount', '812345678903', 'Gresik', ''),
(7, 'Hakim Ziyech', '81098765432', 'Mojokerto', ''),
(9, 'awdawd', '090', 'aiwdiawjd', ''),
(10, 'robet', '0898', 'Ds.Banteng, Rt 15 Rw 05,Barengkrajan,Krian,Sidoarjo', '2021-06-10'),
(11, 'robet', '1213123', 'Ds.Banteng, Rt 15 Rw 05,Barengkrajan,Krian,Sidoarjo', '2021-06-08');

-- --------------------------------------------------------

--
-- Table structure for table `level_user`
--

CREATE TABLE `level_user` (
  `id_status` int(10) NOT NULL,
  `status_level` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `level_user`
--

INSERT INTO `level_user` (`id_status`, `status_level`) VALUES
(1, 'Superadmin'),
(2, 'admin');

-- --------------------------------------------------------

--
-- Stand-in structure for view `list_barang`
-- (See below for the actual view)
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
-- Table structure for table `log_data_barang`
--

CREATE TABLE `log_data_barang` (
  `id_log_barang` int(11) NOT NULL,
  `id_barang` int(11) NOT NULL,
  `harga_lama` int(11) NOT NULL,
  `harga_baru` int(11) NOT NULL,
  `waktu_perubahan` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `log_data_barang`
--

INSERT INTO `log_data_barang` (`id_log_barang`, `id_barang`, `harga_lama`, `harga_baru`, `waktu_perubahan`) VALUES
(12, 5, 45000, 45000, '2021-06-08'),
(13, 5, 45000, 45000, '2021-06-08'),
(14, 5, 45000, 45000, '2021-06-08'),
(15, 5, 45000, 45000, '2021-06-08'),
(16, 3, 150000, 150000, '2021-06-08'),
(17, 7, 30000, 30000, '2021-06-08');

-- --------------------------------------------------------

--
-- Table structure for table `pengembalian`
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

--
-- Dumping data for table `pengembalian`
--

INSERT INTO `pengembalian` (`id_pengembalian`, `id_admin`, `id_barang`, `id_customer`, `id_sewa`, `tanggal_kembali`, `keterangan`, `lama_sewa`, `biaya_sewa`, `denda`, `total_pembayaran`, `keterangan_bayar`) VALUES
(23, 1, 5, 5, 24, '2021-06-11', 'makasi mas', 3, 45000, 0, 135000, 'terbayar');

-- --------------------------------------------------------

--
-- Table structure for table `penyewaan`
--

CREATE TABLE `penyewaan` (
  `id_sewa` int(11) NOT NULL,
  `id_admin` int(11) NOT NULL,
  `id_barang` int(11) NOT NULL,
  `id_customer` int(11) NOT NULL,
  `tanggal_sewa` date NOT NULL,
  `waktu_sewa` int(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `penyewaan`
--

INSERT INTO `penyewaan` (`id_sewa`, `id_admin`, `id_barang`, `id_customer`, `tanggal_sewa`, `waktu_sewa`) VALUES
(25, 1, 5, 6, '2021-06-12', 2),
(26, 1, 3, 3, '2021-06-08', 3),
(27, 1, 7, 5, '2021-06-07', 3);

-- --------------------------------------------------------

--
-- Structure for view `barang_ready`
--
DROP TABLE IF EXISTS `barang_ready`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `barang_ready`  AS  select count(`barang`.`id_barang`) AS `COUNT(id_barang)` from `barang` where `barang`.`keterangan` = 'tersedia' ;

-- --------------------------------------------------------

--
-- Structure for view `barang_sedang_dipinjam`
--
DROP TABLE IF EXISTS `barang_sedang_dipinjam`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `barang_sedang_dipinjam`  AS  select count(`penyewaan`.`id_sewa`) AS `COUNT(id_sewa)` from `penyewaan` ;

-- --------------------------------------------------------

--
-- Structure for view `list_barang`
--
DROP TABLE IF EXISTS `list_barang`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `list_barang`  AS  select `barang`.`id_barang` AS `id_barang`,`barang`.`jenis_barang` AS `jenis_barang`,`barang`.`nama_barang` AS `nama_barang`,`barang`.`harga_sewa` AS `harga_sewa`,`barang`.`keterangan` AS `keterangan` from `barang` where `barang`.`keterangan` in (select `barang`.`keterangan` from DUAL  where `barang`.`keterangan` = 'tersedia') ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`id_admin`),
  ADD KEY `id_status` (`id_status`);

--
-- Indexes for table `barang`
--
ALTER TABLE `barang`
  ADD PRIMARY KEY (`id_barang`);

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`id_customer`);

--
-- Indexes for table `level_user`
--
ALTER TABLE `level_user`
  ADD PRIMARY KEY (`id_status`);

--
-- Indexes for table `log_data_barang`
--
ALTER TABLE `log_data_barang`
  ADD PRIMARY KEY (`id_log_barang`);

--
-- Indexes for table `pengembalian`
--
ALTER TABLE `pengembalian`
  ADD PRIMARY KEY (`id_pengembalian`),
  ADD KEY `id_admin` (`id_admin`),
  ADD KEY `id_barang` (`id_barang`),
  ADD KEY `id_customer` (`id_customer`),
  ADD KEY `id_sewa` (`id_sewa`);

--
-- Indexes for table `penyewaan`
--
ALTER TABLE `penyewaan`
  ADD PRIMARY KEY (`id_sewa`),
  ADD KEY `id_admin` (`id_admin`),
  ADD KEY `id_barang` (`id_barang`),
  ADD KEY `id_customer` (`id_customer`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `id_admin` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `barang`
--
ALTER TABLE `barang`
  MODIFY `id_barang` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `customer`
--
ALTER TABLE `customer`
  MODIFY `id_customer` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `log_data_barang`
--
ALTER TABLE `log_data_barang`
  MODIFY `id_log_barang` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `pengembalian`
--
ALTER TABLE `pengembalian`
  MODIFY `id_pengembalian` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `penyewaan`
--
ALTER TABLE `penyewaan`
  MODIFY `id_sewa` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `admin`
--
ALTER TABLE `admin`
  ADD CONSTRAINT `admin_ibfk_1` FOREIGN KEY (`id_status`) REFERENCES `level_user` (`id_status`);

--
-- Constraints for table `pengembalian`
--
ALTER TABLE `pengembalian`
  ADD CONSTRAINT `pengembalian_ibfk_1` FOREIGN KEY (`id_admin`) REFERENCES `admin` (`id_admin`),
  ADD CONSTRAINT `pengembalian_ibfk_2` FOREIGN KEY (`id_barang`) REFERENCES `barang` (`id_barang`),
  ADD CONSTRAINT `pengembalian_ibfk_3` FOREIGN KEY (`id_customer`) REFERENCES `customer` (`id_customer`);

--
-- Constraints for table `penyewaan`
--
ALTER TABLE `penyewaan`
  ADD CONSTRAINT `penyewaan_ibfk_1` FOREIGN KEY (`id_admin`) REFERENCES `admin` (`id_admin`),
  ADD CONSTRAINT `penyewaan_ibfk_2` FOREIGN KEY (`id_barang`) REFERENCES `barang` (`id_barang`),
  ADD CONSTRAINT `penyewaan_ibfk_3` FOREIGN KEY (`id_customer`) REFERENCES `customer` (`id_customer`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
