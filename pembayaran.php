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
            if($r['id_status'] == 2){
        ?>
            <a class="sidebar-brand d-flex align-items-center justify-content-center" href="beranda.php">
                <div class="sidebar-brand-icon">
                    <img src="img/icon.png" width="30px" height="30px">
                </div>
                <div class="sidebar-brand-text mx-3">Puncak Petualang</div>
            </a>
            <hr class="sidebar-divider my-0">
            <li class="nav-item">
                <a class="nav-link" href="beranda.php">
                    <i class="fas fa-fw fa-tachometer-alt"></i>
                    <span>Beranda</span>
                </a>
            </li>
            <hr class="sidebar-divider my-0">
            <li class="nav-item">
                <a class="nav-link" href="data_barang.php">
                <img alt="Image placeholder" src="img/katalog.png">
                    <span>&nbsp;Data Barang</span>
                </a>
            </li>
            <hr class="sidebar-divider my-0">
            <li class="nav-item">
                <a class="nav-link" href="peminjaman.php">
                <img alt="Image placeholder" src="img/pinjam.png">
                    <span>&nbsp;Penyewaan</span>
                </a>
            </li>
            <hr class="sidebar-divider my-0">
            <li class="nav-item active">
                <a class="nav-link" href="pengembalian.php">
                <img alt="Image placeholder" src="img/kembali.png">
                    <span>&nbsp;Pengembalian</span>
                </a>
            </li>
            <hr class="sidebar-divider my-0">
            <br>
            <div class="text-center d-none d-md-inline">
                <button class="rounded-circle border-0" id="sidebarToggle"></button>
            </div>
        <?php
            } else if($r['id_status'] == 1){
        ?>
            <a class="sidebar-brand d-flex align-items-center justify-content-center" href="beranda.php">
                <div class="sidebar-brand-icon rotate-n-15">
                    <img src="img/dashboard.png" width="30px" height="30px">
                </div>
                <div class="sidebar-brand-text mx-3">Puncak Petualang</div>
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
                <a class="nav-link" href="data_barang_admin.php">
                    <i class="fas fa-fw fa-folder"></i>
                    <span>Data Mobil</span>
                </a>
            </li>
            <hr class="sidebar-divider my-0">
            <li class="nav-item">
                <a class="nav-link" href="data_transaksi.php">
                    <i class="fas fa-fw fa-folder"></i>
                    <span>Data Transaksi</span>
                </a>
            </li>
            <hr class="sidebar-divider my-0">
            <br>
            <div class="text-center d-none d-md-inline">
                <button class="rounded-circle border-0" id="sidebarToggle"></button>
            </div>
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
                    <h1 class="h3 mb-0 text-gray-800">Pengembalian</h1>
                </div>
                <section class="mar-top--x-3 mar-bottom--x-5">
                    <div class="card shadow mb-4">
                        <div class="card-body">
                            <div class="responsive">
                                <div class="judul">
                                    <h4 align="center">Transaksi Pembayaran</h4>
                                    <br>
                                </div>
                                <form action="" method="post">
                                    <?php
                                        $lama_sewa = ""; 
                                        $biaya_sewa = "";
                                        $denda = "";
                                        $tagihan = "";
                                    ?>
                                    <input type="hidden" name="id_admin" value="<?php echo $r['id_admin'];?>">
                                    <div class="form-group row">
                                        <label class="col-sm-2 col-form-label">Id Sewa</label>
                                        <div class="col-sm-10">
                                            <select name="id_sewa" class="form-control">
                                                <?php 
                                                $sql1="SELECT * FROM pengembalian WHERE keterangan_bayar='belum terbayar'";
                                                $hasil=mysqli_query($conn,$sql1);
                                                $no=0;
                                                while ($data2 = mysqli_fetch_array($hasil)) {
                                                $no++;
                                                ?>
                                            
                                                <option  type="integer" value="<?php echo $data2['id_sewa'];?>" name="id_sewa"><?php echo $data2['id_sewa'];?></option>
                                                
                                                <?php 
                                                }
                                                ?>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 col-form-label"></label>
                                        <div class="col-sm-10">
                                            <button type="submit" name="hitung" class="d-none d-sm-inline-block btn btn-sm btn-success shadow-sm">Hitung</button>
                                        </div>
                                    </div>
                                    <?php
                                        if(isset($_POST['hitung'])){
                                            $id_sewa = $_POST['id_sewa'];
                                            $query_read = mysqli_query($conn, "SELECT lama_sewa, biaya_sewa, denda FROM pengembalian WHERE id_sewa = $id_sewa");
                                            
                                            while($test = mysqli_fetch_array($query_read)){
                                                $lama_sewa = $test[0]; 
                                                $biaya_sewa = $test[1];
                                                $denda = $test[2];
                                            }
                                            $tagihan = ($lama_sewa*$biaya_sewa)+$denda;            
                                        }
                                    ?>  
                                    
                                    <div class="form-group row">
                                        <label  class="col-sm-2 col-form-label">Lama Sewa</label>
                                        <div class="col-sm-10">
                                            <input type="text" name="lama_sewa"  value="<?php echo $lama_sewa; ?>" class="form-control" placeholder="Lama Sewa" disabled>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label  class="col-sm-2 col-form-label">Biaya Sewa</label>
                                        <div class="col-sm-10">
                                            <input type="number" name="biaya_sewa" value="<?php echo $biaya_sewa; ?>" class="form-control" placeholder="Biaya Sewa" disabled>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label  class="col-sm-2 col-form-label">Denda</label>
                                        <div class="col-sm-10">
                                            <input type="number" name="denda" value="<?php echo $denda; ?>" class="form-control" placeholder="Denda (Dalam Rupiah)" disabled>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label  class="col-sm-2 col-form-label">Tagihan</label>
                                        <div class="col-sm-10">
                                            <input type="number" name="tagihan" value="<?php echo $tagihan; ?>" class="form-control" placeholder="Tagihan (Dalam Rupiah)" disabled>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label  class="col-sm-2 col-form-label">Uang yang dibayarkan</label>
                                        <div class="col-sm-10">
                                            <input type="number" name="bayar" class="form-control" placeholder="Masukkan Uang Yang Dibayarkan (Dalam Rupiah)">
                                        </div>
                                    </div>
                                    
                                    <div class="form-group row">
                                        <label class="col-sm-2 col-form-label"></label>
                                        <div class="col-sm-10">
                                            <button type="submit" name="kirim" class="d-none d-sm-inline-block btn btn-sm btn-success shadow-sm">Bayar</button>
                                        </div>
                                    </div>
                                    <input hidden type="number" name="id_sewa1" value="<?php echo $id_sewa; ?>">
                                    <?php
                                        if(isset($_POST['kirim'])){
                                            $id_sewa1 = $_POST['id_sewa1'];
                                            $query1 = "SELECT lama_sewa, biaya_sewa, denda FROM pengembalian WHERE id_sewa = $id_sewa1";                                           
                                            $query_read = mysqli_query($conn, $query1);
                                            while($test = mysqli_fetch_array($query_read)){
                                                $lama_sewa = $test[0]; 
                                                $biaya_sewa = $test[1];
                                                $denda = $test[2];
                                            }
                                            $tagihan = ($lama_sewa*$biaya_sewa)+$denda; 
                                            $bayar = $_POST['bayar'];
                                            $bayar = (int) filter_var($bayar, FILTER_SANITIZE_NUMBER_INT);
                                            $tagihan = (int) filter_var($tagihan, FILTER_SANITIZE_NUMBER_INT);
                                            $kembalian = $bayar-$tagihan; 
                                            
                                            mysqli_query($conn, "UPDATE pengembalian SET keterangan_bayar = 'terbayar' WHERE id_sewa = $id_sewa1");     
                                        }
                                    ?>  
                                    <div class="form-group row">
                                        <label  class="col-sm-2 col-form-label">Kembalian</label>
                                        <div class="col-sm-10">
                                            <input type="number" name="kembalian"  value="<?php echo $kembalian; ?>" class="form-control" placeholder="Uang Kembalian (Dalam Rupiah)" disabled>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </section>
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