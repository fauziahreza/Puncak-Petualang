<!DOCTYPE html>

<?php
include "connection/koneksi.php";
session_start();
ob_start();

$id = $_SESSION['id_admin'];

if(isset ($_SESSION['username'])){
    $query = "select * from admin natural join level_user where id_admin = $id";

    mysqli_query($conn, $query);
    $sql = mysqli_query($conn, $query);
    
    while($r = mysqli_fetch_array($sql)){
        $nama = $r['nama'];
?>

<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>Puncak Petualang</title>
    <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">
    <link href="css/sb-admin-2.min.css" rel="stylesheet">
    <link href="css/arabic.css" rel="stylesheet" >
</head>

<body id="page-top">
    <div id="wrapper">

        <!-- Sidebar -->
        <ul class="navbar-nav bg-gradient-info sidebar sidebar-dark accordion" id="accordionSidebar">
        <?php
            if($r['id_status'] == 1){
        ?>
            <a class="sidebar-brand d-flex align-items-center justify-content-center" href="beranda.php">
                <div class="sidebar-brand-icon rotate-n-15">
                    <img src="img/dashboard.png" width="30px" height="30px">
                </div>
                <div class="sidebar-brand-text mx-3">Rent Car</div>
            </a>
            <hr class="sidebar-divider my-0">
            <li class="nav-item active">
                <a class="nav-link" href="beranda.php">
                    <i class="fas fa-fw fa-tachometer-alt"></i>
                    <span>Beranda</span>
                </a>
            </li>
            <hr class="sidebar-divider my-0">
            <li class="nav-item">
                <a class="nav-link" href="data_mobil.php">
                    <i class="fas fa-fw fa-folder"></i>
                    <span>Data Mobil</span>
                </a>
            </li>
            <hr class="sidebar-divider my-0">
            <li class="nav-item">
                <a class="nav-link" href="peminjaman.php">
                    <i class="fas fa-fw fa-folder"></i>
                    <span>Penyewaan</span>
                </a>
            </li>
            <hr class="sidebar-divider my-0">
            <li class="nav-item">
                <a class="nav-link" href="pengembalian.php">
                    <i class="fas fa-fw fa-folder"></i>
                    <span>Pengembalian</span>
                </a>
            </li>
            <hr class="sidebar-divider my-0">
        <?php
            } else if($r['id_status'] == 2){
        ?>
            <a class="sidebar-brand d-flex align-items-center justify-content-center" href="beranda.php">
                <div class="sidebar-brand-icon">
                    <img src="img/icon.png" width="30px" height="30px">
                </div>
                <div class="sidebar-brand-text mx-3">Rent Car</div>
            </a>
            <hr class="sidebar-divider my-0">
            <li class="nav-item">
                <a class="nav-link" href="beranda.php">
                    <i class="fas fa-fw fa-tachometer-alt"></i>
                    <span>Beranda</span>
                </a>
            </li>
            <hr class="sidebar-divider my-0">
            <li class="nav-item active">
                <a class="nav-link" href="data_mobil_admin.php">
                    <img alt="Image placeholder" src="img/mobil.png">
                    <span>Data Mobil</span>
                </a>
            </li>
            <hr class="sidebar-divider my-0">
            <li class="nav-item">
                <a class="nav-link" href="data_transaksi.php">
                    <img alt="Image placeholder" src="img/pinjam.png">
                    <span>Data Transaksi</span>
                </a>
            </li>
            <hr class="sidebar-divider my-0">
        <?php
            }
        ?>
        </ul>
        <!-- End of Sidebar -->

        <!-- Content Wrapper -->
        <div id="content-wrapper" class="d-flex flex-column">
            <div id="content">
                  
                <!-- Topbar -->
                <nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">
                    <ul class="navbar-nav ml-auto">
                        
                        <!-- Informasi User -->
                        <li class="nav-item dropdown no-arrow">
                            <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button"
                                data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <span class="mr-2 d-none d-lg-inline text-gray-600 small"><?php echo $r['nama'];?></span>
                                <img class="img-profile rounded-circle"
                                    src="img/undraw_profile.svg">
                            </a>
                            
                            <!-- Dropdown User -->
                            <div class="dropdown-menu dropdown-menu-right shadow animated--grow-in"
                                aria-labelledby="userDropdown">
                                <a class="dropdown-item" id="custom-dropdown" href="logout.php" data-toggle="modal" data-target="#logoutModal">
                                    <i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
                                    Logout
                                </a>
                            </div>
                        </li>
                    </ul>
                </nav>
                <!-- End of Topbar -->

            <!-- Content -->
            <div class="container-fluid">
                <div class="d-sm-flex align-items-center justify-content-between mb-4">
                    <h1 class="h3 mb-0 text-gray-800">Data Mobil</h1>
                </div>
                <section class="mar-top--x-3 mar-bottom--x-5">
                    <div class="card shadow mb-4">
                        <div class="card-body">
                            <div class="responsive">
                                <div class="judul">
                                    <h4 align="center">Tambah Mobil Baru</h4>
                                    <br>
                                </div>
                                <form action="" method="post" class="user">
                                    <div class="form-group row">
                                        <label for="Id Mobil" class="col-sm-2 col-form-label">Id Mobil</label>
                                        <div class="col-sm-10">
                                            <input type="text" name="id_mobil" class="form-control" placeholder="Masukkan Id Mobil" required>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label for="Nopol Mobil" class="col-sm-2 col-form-label">Nopol Mobil</label>
                                        <div class="col-sm-10">
                                            <input type="text" name="nopol_mobil" class="form-control" placeholder="Masukkan Nopol Mobil" required>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label for="tipe Mobil" class="col-sm-2 col-form-label">Tipe Mobil</label>
                                        <div class="col-sm-10">
                                            <input type="text" name="tipe_mobil" class="form-control" placeholder="Masukkan Tipe Mobil" required>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label for="Tahun Produksi" class="col-sm-2 col-form-label">Tahun Produksi</label>
                                        <div class="col-sm-10">
                                            <input type="text" name="tahun_produksi" class="form-control" placeholder="Masukkan Tahun Produksi" required>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label for="Harga Sewa" class="col-sm-2 col-form-label">Harga Sewa</label>
                                        <div class="col-sm-10">
                                            <input type="text" name="harga_sewa" class="form-control"  placeholder="Masukkan Harga Sewa" required>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label for="Keterangan" class="col-sm-2 col-form-label">Keterangan</label>
                                        <div class="col-sm-10">
                                            <input type="text" name="keterangan" class="form-control" placeholder="Masukkan Keterangan" required>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 col-form-label"></label>
                                        <div class="col-sm-10">
                                            <button type="submit" name="kirim_data" class="d-none d-sm-inline-block btn btn-sm btn-success shadow-sm">Tambahkan Mobil</button>
                                        </div>
                                    </div>
                                </form>
                                <?php
                                    if(isset($_POST['kirim_data'])){
                                        $id_mobil = $_POST['id_mobil'];
                                        $nopol_mobil = $_POST['nopol_mobil'];
                                        $tipe_mobil = $_POST['tipe_mobil'];
                                        $tahun_produksi = $_POST['tahun_produksi'];
                                        $harga_sewa = $_POST['harga_sewa'];
                                        $keterangan = $_POST['keterangan'];
                                        $id_valid = false;
                                        $verifikasi_id = "SELECT id_mobil FROM mobil";
                                        $query_cek = mysqli_query($conn, $verifikasi_id);
                                        while($data = mysqli_fetch_array($query_cek)){
                                            $verifikasi_id = $data['id_mobil'];
                                            if($id_mobil != $verifikasi_id){
                                                $id_valid = true;
                                            } elseif($id_mobil == $verifikasi_id){
                                                $id_valid = false;
                                                break;
                                            }
                                        }
                                        if($id_valid == true){
                                            $query_tambah = "CALL tambah_mobil('$id_mobil','$nopol_mobil','$tipe_mobil','$tahun_produksi','$harga_sewa','$keterangan')";
                                            $sql_tambah = mysqli_query($conn, $query_tambah);
                                            if($sql_tambah){
                                                $_SESSION['tambah'] = 'sukses';
                                                echo "<script>alert('Berhasil Menambahkan Mobil!')</script>";
                                            } else {
                                                echo "<script>alert('Gagal Menambahkan Mobil!')</script>";
                                                echo mysqli_error($conn);
                                            }
                                        } else {
                                            echo "<script>alert('Id Mobil Sudah Ada!')</script>";
                                        }                
                                    }
                                ?> 
                            </div>
                        </div>
                    </div>             
                </section>
                <br><br><br><br><br><br><br><br>
            </div>
            <!-- End of Content -->
        </div>
    </div>

    <!-- Logout-->
    <div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
        aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Ingin keluar?</h5>
                    <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body">Pilih "Keluar" jika ingin meninggalkan halaman.</div>
                <div class="modal-footer">
                    <button class="d-none d-sm-inline-block btn btn-sm btn-secondary shadow-sm" type="button" data-dismiss="modal">Batal</button>
                    <a class="d-none d-sm-inline-block btn btn-sm btn-danger shadow-sm" href="logout.php">Keluar</a>
                </div>
            </div>
        </div>
    </div>

    <!-- JavaScript-->
    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="vendor/jquery-easing/jquery.easing.min.js"></script>
    <script src="js/sb-admin-2.min.js"></script>
</body>
</html>
<?php
  }
} else {
  header('location: logout.php');
}
ob_flush();
?>