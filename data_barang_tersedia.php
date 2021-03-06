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
    <link rel="stylesheet" href="css/Styles.css">
    <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">
    <link href="css/sb-admin-2.min.css" rel="stylesheet">
    <link href="css/arabic.css" rel="stylesheet" >
</head>

<body id="page-top">
    <div id="wrapper">

        <!-- Sidebar -->
        <ul class="navbar-nav gradient-bg sidebar sidebar-dark accordion" id="accordionSidebar">
        <?php
            if($r['id_status'] == 2){
        ?>
            <a class="sidebar-brand d-flex align-items-center justify-content-center" href="#">
                <div class="sidebar-brand-icon">
                    <img src="img/logo.svg" width="30px" height="30px">
                </div>
                <div class="sidebar-brand-text mx-3">Puncak Petualang</div>
            </a>
            <hr class="sidebar-divider my-0">
            <li class="nav-item active">
                <a class="nav-link" href="data_barang.php">
                <img alt="Image placeholder" src="img/katalog.svg" width="25px" height="25px">
                    <span>&nbsp;Katalog</span>
                </a>
            </li>
            <hr class="sidebar-divider my-0">
            <li class="nav-item">
                <a class="nav-link" href="peminjaman.php">
                <img alt="Image placeholder" src="img/sewa.svg" width="25px" height="25px">
                    <span>&nbsp;Sewa Barang</span>
                </a>
            </li>
            <hr class="sidebar-divider my-0">
            <li class="nav-item">
                <a class="nav-link" href="pengembalian.php">
                <img alt="Image placeholder" src="img/kembali.svg" width="25px" height="25px">
                    <span>&nbsp;Pengembalian</span>
                </a>
            </li>
            <hr class="sidebar-divider my-0">
            <br>
        <?php
            } else if($r['id_status'] == 1){
        ?>
            <a class="sidebar-brand d-flex align-items-center justify-content-center" href="#">
                <div class="sidebar-brand-icon">
                    <img src="img/logo.svg" width="30px" height="30px">
                </div>
                <div class="sidebar-brand-text mx-3">Puncak Petualang</div>
            </a>
            <hr class="sidebar-divider my-0">
            <li class="nav-item">
                <a class="nav-link" href="data_barang_admin.php">
                <img alt="Image placeholder" src="img/katalog.svg" width="25px" height="25px">
                    <span>&nbsp;Katalog</span>
                </a>
            </li>
            <hr class="sidebar-divider my-0">
            <li class="nav-item">
                <a class="nav-link" href="data_transaksi.php">
                <img alt="Image placeholder" src="img/tf.svg" width="25px" height="25px">
                    <span>&nbsp;Transaksi</span>
                </a>
            </li>
            <hr class="sidebar-divider my-0">
            <br>
        <?php
            }
        ?>
        </ul>
        <!-- End of Sidebar -->

        <!-- Content Wrapper -->
        <div id="content-wrapper" class="d-flex flex-column">
            <div id="content">
                  
                <!-- Topbar -->
                <nav class="navbar navbar-expand navbar-light gradient-bg topbar mb-4 static-top shadow">
                    <ul class="navbar-nav ml-auto">
                        
                        <!-- Informasi User -->
                        <li class="nav-item dropdown no-arrow">
                            <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button"
                                data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <span class="mr-2 d-none d-lg-inline text-white small"><?php echo $r['nama'];?></span>
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
                    <h1 class="h3 mb-0 text-gray-800">Data Barang</h1>
                    <a href="data_barang.php" class="d-none d-sm-inline-block btn btn-sm btn-danger shadow-sm">Tampilkan Seluruh Data Barang</a>
                </div>
                <section class="mar-top--x-3 mar-bottom--x-5">
                    <div class="card shadow mb-4">
                        <div class="card-body">
                            <div class="table-responsive">
                            <?php
                            $query_data_barang = "SELECT * FROM list_barang";
                            $sql_data_barang = mysqli_query($conn, $query_data_barang);
                            $no = 1;
                            ?>
                                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                    <thead align="center">
                                        <tr>
                                            <th>No.</th>
                                            <th>Id Barang</th>
                                            <th>Jenis Barang</th>
                                            <th>Nama Barang</th>
                                            <th>Harga Sewa</th>
                                            <th>Keterangan</th>
                                        </tr>
                                    </thead>
                                    <tbody align="center">
                                    <?php
                                        while($r_dt_barang = mysqli_fetch_array($sql_data_barang)){
                                    ?>
                                        <tr class="odd gradeX">
                                        <td><center><?php echo $no++; ?>.</center></td>
                                        <td><?php echo $r_dt_barang['id_barang']; ?></td>
                                        <td><?php echo $r_dt_barang['jenis_barang']; ?></td>
                                        <td><?php echo $r_dt_barang['nama_barang']; ?></td>
                                        <td>Rp.<?php echo number_format($r_dt_barang['harga_sewa'],0,',','.'); ?>,-/hari</td>
                                        <td><?php echo $r_dt_barang['keterangan']; ?></td>
                                        </tr>
                                    <?php
                                        }
                                    ?>
                                    </tbody>
                                </table>  
                            </div>
                        </div>
                    </div>
                </section>
            </div>
            <br><br><br><br><br><br><br><br><br><br>
            <!-- End of Content -->

            <!-- Footer -->
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
                        <span aria-hidden="true">??</span>
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