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
            <li class="nav-item">
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
            <li class="nav-item active">
                <a class="nav-link" href="pengembalian.php">
                <img alt="Image placeholder" src="img/kembali.svg" width="25px" height="25px">
                    <span>&nbsp;Pengembalian</span>
                </a>
            </li>
            <hr class="sidebar-divider my-0">
        <?php
            } else if($r['id_status'] == 1){
        ?>
            <a class="sidebar-brand d-flex align-items-center justify-content-center" href="#">
                <div class="sidebar-brand-icon rotate-n-15">
                    <img src="img/dashboard.png" width="30px" height="30px">
                </div>
                <div class="sidebar-brand-text mx-3">Puncak Petualang</div>
            </a>
            <hr class="sidebar-divider my-0">
            <li class="nav-item">
                <a class="nav-link" href="data_barang_admin.php">
                    <i class="fas fa-fw fa-folder"></i>
                    <span>Data Barang</span>
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
                    <h1 class="h3 mb-0 text-gray-800">Pengembalian</h1>
                </div>
                <section class="mar-top--x-3 mar-bottom--x-5">
                    <div class="card shadow mb-4">
                        <div class="card-body">
                            <div class="responsive">
                                <div class="judul">
                                    <h4 align="center">Tambah Data Pengembalian</h4>
                                    <br>
                                </div>
                                <form action="" method="post">
                                    <input type="hidden" name="id_admin" value="<?php echo $r['id_admin'];?>">
                                    <div class="form-group row">
                                        <label class="col-sm-2 col-form-label">Id Sewa</label>
                                        <div class="col-sm-10">
                                            <select name="id_sewa">
                                                    <?php 
                                                $sql1="select * from penyewaan";
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
                                            <a href="data_sewa.php" name="data_customer" class="d-none d-sm-inline-block btn btn-sm btn-danger shadow-sm"><i class="fas fa-fw fa-eye"></i>Lihat Data</a>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label  class="col-sm-2 col-form-label">Tanggal Kembali</label>
                                        <div class="col-sm-10">
                                            <input type="date" name="tanggal_kembali" class="form-control" placeholder="Masukkan Tanggal Kembali" required>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label  class="col-sm-2 col-form-label">Keterangan</label>
                                        <div class="col-sm-10">
                                            <input type="text" name="keterangan" class="form-control" placeholder="Masukkan Keterangan" required>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label  class="col-sm-2 col-form-label">Denda</label>
                                        <div class="col-sm-10">
                                            <input type="integer" name="denda" class="form-control" placeholder="Masukkan Denda (Dalam Rupiah)" required>
                                        </div>
                                    </div>
                                    
                                    <div class="form-group row">
                                        <label class="col-sm-2 col-form-label"></label>
                                        <div class="col-sm-10">
                                            <button type="submit" name="kirim" class="d-none d-sm-inline-block btn btn-sm btn-success shadow-sm">Tambah Data</button>
                                        </div>
                                    </div>
                                </form>
                                <?php
                                    if(isset($_POST['kirim'])){
                                        $id_sewa=$_POST["id_sewa"];

                                        $sql2="SELECT * FROM penyewaan WHERE id_sewa=$id_sewa";

                                        $hasil2=mysqli_query($conn,$sql2);
                                        while ($data2 = mysqli_fetch_array($hasil2)){
                                        $id_barang=$data2['id_barang'];
                                        $id_customer=$data2['id_customer'];
                                        }

                                        $id_admin=$_POST["id_admin"];


                                        $tanggal_kembali=$_POST["tanggal_kembali"];
                                        $keterangan=$_POST["keterangan"];
                                        $denda=$_POST["denda"];

                                        $sql3="SELECT waktu_sewa FROM penyewaan WHERE id_sewa=$id_sewa";
                                        
                                        
                                        
                                        $hasil3=mysqli_query($conn,$sql3);
                                        
                                        $data3 = mysqli_fetch_array($hasil3);
                                        $lama_sewa=$data3[0];

                                        $sql5="SELECT harga_sewa FROM barang WHERE id_barang=$id_barang";
                                        $hasil5=mysqli_query($conn,$sql5);
                                        $data5 = mysqli_fetch_array($hasil5);

                                        $biaya_sewa=$data5[0];

                                        $hargatotal=($lama_sewa*$biaya_sewa)+$denda;
                                        $keterangan_bayar = "belum terbayar";
                                        

                                        //Query input menginput data kedalam tabel barang
                                        
                                        mysqli_begin_transaction($conn);
                                        $sql4="CALL pengembalian(null,$id_admin,$id_barang,$id_customer,$id_sewa,'$tanggal_kembali','$keterangan',$lama_sewa,$biaya_sewa,$denda,$hargatotal,'$keterangan_bayar')";
                                        
                                        //Mengeksekusi/menjalankan query diatas
                                        	
                                        $hasil=mysqli_query($conn,$sql4);

                                        //Kondisi apakah berhasil atau tidak
                                        if (mysqli_commit($conn)) {
                                            echo "<script>alert('Berhasil Insert Data!');</script>";
                                            header("Refresh:0; url=pembayaran.php");
                                            echo mysqli_error($conn);
                                        }
                                        else {
                                            mysqli_rollback($conn);
                                            echo "<script>alert('Gagal Insert Data!')</script>";
                                            echo mysqli_error($conn);
                                        }  
                                    }  
                                ?>
                            </div>
                        </div>
                    </div>
                </section>
            </div>
            <br><br><br><br>
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