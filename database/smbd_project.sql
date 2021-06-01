-- phpMyAdmin SQL Dump
-- version 5.0.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 01 Jun 2021 pada 17.33
-- Versi server: 10.4.14-MariaDB
-- Versi PHP: 7.2.34

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `smbd_project`
--

DELIMITER $$
--
-- Prosedur
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `pengembalian` (IN `vidadmin` VARCHAR(10), IN `vidmobil` VARCHAR(10), IN `vidcustomer` VARCHAR(10), IN `vidsewa` VARCHAR(10), IN `vtanggalkembali` DATE, IN `vketerangan` VARCHAR(10), IN `vdenda` INT(10))  BEGIN UPDATE mobil SET keterangan='tersedia' WHERE id_mobil = vidmobil ; 
INSERT INTO `pengembalian` (`id_admin`, `id_mobil`, `id_customer`, `id_sewa`, `tanggal_kembali`, `keterangan`, `denda`) 
VALUES (vidadmin, vidmobil, vidcustomer, vidsewa, vtanggalkembali, vketerangan, vdenda); DELETE FROM `penyewaan` WHERE `id_sewa` = vidsewa; 
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `penyewaan` (IN `vidadmin` VARCHAR(10), IN `vidmobil` VARCHAR(10), IN `vidcustomer` VARCHAR(10), IN `vtanggalsewa` DATE, IN `vwaktusewa` VARCHAR(10))  BEGIN UPDATE mobil SET keterangan='tidak tersedia' 
    WHERE id_mobil = vidmobil 
    ;
    INSERT INTO `penyewaan` (`id_admin`, `id_mobil`, `id_customer`, `tanggal_sewa`, `waktu_sewa`) 
    VALUES (vidadmin,vidmobil, vidcustomer, vtanggalsewa, vwaktusewa);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `tambah_mobil` (IN `vidmobil` INT(11), IN `vnopolmobil` VARCHAR(100), IN `vtipemobil` VARCHAR(100), IN `vtahun_produksi` INT(11), IN `vhargasewa` INT(11), IN `vketerangan` VARCHAR(100))  BEGIN 
INSERT INTO `mobil`(`id_mobil`, `nopol_mobil`, `tipe_mobil`, `tahun_produksi`, `harga_sewa`, `keterangan`)
VALUES (vidmobil,vnopolmobil,vtipemobil,vtahun_produksi,vhargasewa,vketerangan);
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
  `id_level` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `admin`
--

INSERT INTO `admin` (`id_admin`, `username`, `password`, `nama`, `id_level`) VALUES
(1, 'jm', 'jm', 'JM Havidz', 1),
(2, 'yudha', 'yudha', 'Yudha Krisnawan', 2),
(3, 'ridho', 'ridho', 'Ridho Hidayatullah', 1),
(4, 'fajar', 'fajar', 'Fajar Naufal', 2),
(5, 'andicho', 'andicho', 'Andicho Putra', 1);

-- --------------------------------------------------------

--
-- Struktur dari tabel `customer`
--

CREATE TABLE `customer` (
  `id_customer` int(11) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `no_ktp` int(16) NOT NULL,
  `alamat` varchar(100) NOT NULL,
  `tanggal_lahir` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `customer`
--

INSERT INTO `customer` (`id_customer`, `nama`, `no_ktp`, `alamat`, `tanggal_lahir`) VALUES
(1, 'Farhan', 3562000, 'Sidoarjo', '2000-07-31'),
(2, 'Risal', 3562001, 'Lamongan', '2000-06-22');

-- --------------------------------------------------------

--
-- Struktur dari tabel `level_user`
--

CREATE TABLE `level_user` (
  `id_level` int(11) NOT NULL,
  `nama_level` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `level_user`
--

INSERT INTO `level_user` (`id_level`, `nama_level`) VALUES
(1, 'Admin'),
(2, 'Superadmin');

-- --------------------------------------------------------

--
-- Struktur dari tabel `mobil`
--

CREATE TABLE `mobil` (
  `id_mobil` int(11) NOT NULL,
  `nopol_mobil` varchar(100) NOT NULL,
  `tipe_mobil` varchar(100) NOT NULL,
  `tahun_produksi` int(11) NOT NULL,
  `harga_sewa` int(11) NOT NULL,
  `keterangan` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `mobil`
--

INSERT INTO `mobil` (`id_mobil`, `nopol_mobil`, `tipe_mobil`, `tahun_produksi`, `harga_sewa`, `keterangan`) VALUES
(1, 'M 331 ML', 'Nissan GTR', 2015, 2000000, 'tersedia'),
(2, 'M 1256 LG', 'Honda Brio', 2021, 2300000, 'tersedia');

-- --------------------------------------------------------

--
-- Struktur dari tabel `pengembalian`
--

CREATE TABLE `pengembalian` (
  `id_pengembalian` int(11) NOT NULL,
  `id_admin` int(11) NOT NULL,
  `id_mobil` int(11) NOT NULL,
  `id_customer` int(11) NOT NULL,
  `id_sewa` int(11) NOT NULL,
  `tanggal_kembali` date NOT NULL,
  `keterangan` varchar(1000) NOT NULL,
  `denda` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `pengembalian`
--

INSERT INTO `pengembalian` (`id_pengembalian`, `id_admin`, `id_mobil`, `id_customer`, `id_sewa`, `tanggal_kembali`, `keterangan`, `denda`) VALUES
(1, 1, 2, 2, 2, '2021-06-03', 'c', 46),
(2, 1, 2, 2, 2, '2021-06-03', 'c', 46),
(3, 1, 2, 2, 2, '2021-06-03', 'c', 46),
(4, 1, 2, 2, 2, '2021-06-02', 'a', 32),
(5, 1, 2, 2, 2, '2020-01-01', 'a', 12),
(6, 1, 2, 2, 2, '2020-01-01', 'a', 12),
(7, 1, 1, 1, 3, '2021-06-02', 'a', 32);

-- --------------------------------------------------------

--
-- Struktur dari tabel `penyewaan`
--

CREATE TABLE `penyewaan` (
  `id_sewa` int(11) NOT NULL,
  `id_admin` int(11) NOT NULL,
  `id_mobil` int(11) NOT NULL,
  `id_customer` int(11) NOT NULL,
  `tanggal_sewa` date NOT NULL,
  `waktu_sewa` int(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`id_admin`),
  ADD KEY `id_level` (`id_level`);

--
-- Indeks untuk tabel `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`id_customer`);

--
-- Indeks untuk tabel `level_user`
--
ALTER TABLE `level_user`
  ADD PRIMARY KEY (`id_level`);

--
-- Indeks untuk tabel `mobil`
--
ALTER TABLE `mobil`
  ADD PRIMARY KEY (`id_mobil`);

--
-- Indeks untuk tabel `pengembalian`
--
ALTER TABLE `pengembalian`
  ADD PRIMARY KEY (`id_pengembalian`),
  ADD KEY `id_admin` (`id_admin`),
  ADD KEY `id_mobil` (`id_mobil`),
  ADD KEY `id_customer` (`id_customer`),
  ADD KEY `id_sewa` (`id_sewa`);

--
-- Indeks untuk tabel `penyewaan`
--
ALTER TABLE `penyewaan`
  ADD PRIMARY KEY (`id_sewa`),
  ADD KEY `id_admin` (`id_admin`),
  ADD KEY `id_mobil` (`id_mobil`),
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
-- AUTO_INCREMENT untuk tabel `customer`
--
ALTER TABLE `customer`
  MODIFY `id_customer` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT untuk tabel `mobil`
--
ALTER TABLE `mobil`
  MODIFY `id_mobil` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT untuk tabel `pengembalian`
--
ALTER TABLE `pengembalian`
  MODIFY `id_pengembalian` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT untuk tabel `penyewaan`
--
ALTER TABLE `penyewaan`
  MODIFY `id_sewa` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `admin`
--
ALTER TABLE `admin`
  ADD CONSTRAINT `admin_ibfk_1` FOREIGN KEY (`id_level`) REFERENCES `level_user` (`id_level`);

--
-- Ketidakleluasaan untuk tabel `pengembalian`
--
ALTER TABLE `pengembalian`
  ADD CONSTRAINT `pengembalian_ibfk_1` FOREIGN KEY (`id_admin`) REFERENCES `admin` (`id_admin`),
  ADD CONSTRAINT `pengembalian_ibfk_2` FOREIGN KEY (`id_mobil`) REFERENCES `mobil` (`id_mobil`),
  ADD CONSTRAINT `pengembalian_ibfk_3` FOREIGN KEY (`id_customer`) REFERENCES `customer` (`id_customer`);

--
-- Ketidakleluasaan untuk tabel `penyewaan`
--
ALTER TABLE `penyewaan`
  ADD CONSTRAINT `penyewaan_ibfk_1` FOREIGN KEY (`id_admin`) REFERENCES `admin` (`id_admin`),
  ADD CONSTRAINT `penyewaan_ibfk_2` FOREIGN KEY (`id_mobil`) REFERENCES `mobil` (`id_mobil`),
  ADD CONSTRAINT `penyewaan_ibfk_3` FOREIGN KEY (`id_customer`) REFERENCES `customer` (`id_customer`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
