CREATE TABLE customer (
  id_customer number(10) NOT NULL,
  nama_customer varchar2(100) NOT NULL,
  alamat varchar2(200) DEFAULT '' NOT NULL,
  no_telpon varchar2(100) DEFAULT '' NOT NULL,
  email varchar2(50) DEFAULT '' NOT NULL,
  PRIMARY KEY (id_customer)
) ;

CREATE TABLE pegawai (
  id_pegawai number(10) NOT NULL,
  nama_pegawai varchar2(100) NOT NULL,
  gaji_pegawai number(10) NOT NULL,
  posisi_pegawai varchar2(100) NOT NULL,
  PRIMARY KEY (id_pegawai)
) ;

CREATE TABLE product (
  id_product number(10) NOT NULL,
  nama_product varchar2(50) DEFAULT '' NOT NULL,
  jenis_product varchar2(100) NOT NULL,
  detail_product varchar2(100) NOT NULL,
  harga_product number(10) NOT NULL,
  stock number(10) NOT NULL,
  PRIMARY KEY (id_product)
) ;

CREATE TABLE pesanan (
  id_order number(10) NOT NULL,
  id_product number(10) NOT NULL,
  id_customer number(10) NOT NULL,
  nama_product varchar2(50) DEFAULT '' NOT NULL,
  detail_product varchar2(100) NOT NULL,
  design_source varchar2(100),
  metode_pembayaran varchar2(50) DEFAULT '' NULL,
  order_date date NOT NULL,
  jumlah number(10) NOT NULL,
  total_bayar number(10) NULL,
  PRIMARY KEY (id_order)
);

drop table pesanan;

ALTER TABLE pesanan add design_source varchar2(100);

ALTER TABLE pesanan ADD FOREIGN KEY (id_product) REFERENCES product(id_product);
ALTER TABLE pesanan ADD FOREIGN KEY (id_customer) REFERENCES customer(id_customer);

INSERT INTO customer (id_customer, nama_customer, alamat, no_telpon, email)
	 SELECT 11, 'Vira', 'Depok', '021212221', 'viraaakris@gmail.com' FROM dual UNION ALL 
	 SELECT 18, 'Wahyu', 'Cakung', '021288990', 'wahyuygy@gmail.com' FROM dual UNION ALL 
	 SELECT 21, 'Dhaifan', 'Cilandak', '021212233', 'dhaifan22@gmail.com' FROM dual UNION ALL 
	 SELECT 22, 'Hedya', 'Lubang Buaya', '021210002', 'hedyatiesya@gmail.com' FROM dual UNION ALL 
	 SELECT 33, 'Syawal', 'Bogor', '021219983', 'syawww@gmail.com' FROM dual;
     
INSERT INTO pegawai (id_pegawai, nama_pegawai, gaji_pegawai, posisi_pegawai)
	 SELECT 1, 'Alfian', 3000000, 'Pemilik' FROM dual UNION ALL 
	 SELECT 2, 'Adnan', 1000000, 'Staff Foto Kopi' FROM dual UNION ALL 
	 SELECT 3, 'Alifia', 2000000, 'Admin' FROM dual UNION ALL 
	 SELECT 4, 'Brillyan', 1000000, 'Staff Percetakan' FROM dual UNION ALL 
	 SELECT 5, 'Ken', 1000000, 'Kasir' FROM dual;
     
INSERT INTO product (id_product, nama_product, jenis_product, detail_product,  harga_product, stock)
    SELECT 101, 'print_bnw', 'jasa', '1 halaman 1 kertas',  1000, 100 FROM dual UNION ALL
    SELECT 102, 'print_bnw', 'jasa', '2 halaman 1 kertas',  1500, 100 FROM dual UNION ALL
    SELECT 103, 'print_warna', 'jasa', '1 halaman 1 kertas',  2000, 100 FROM dual UNION ALL
    SELECT 104, 'print_warna', 'jasa', '2 halaman 1 kertas', 2500, 100 FROM dual UNION ALL
    SELECT 105, 'jilid', 'jasa', 'tulang perekat',  3000, 100 FROM dual UNION ALL
    SELECT 106, 'jilid', 'jasa', 'tulang spiral',  10000, 100 FROM dual UNION ALL
    SELECT 107, 'laminating', 'jasa', 'doff',  3000, 100 FROM dual UNION ALL
    SELECT 108, 'laminating', 'jasa', 'glossy',  3000, 100 FROM dual UNION ALL
    SELECT 109, 'cetak mug', 'jasa', 'mug 200ml',  30000, 100 FROM dual UNION ALL
    SELECT 110, 'cetak mug', 'jasa', 'mug 600ml',  40000, 100 FROM dual UNION ALL
    SELECT 111, 'sablon kaos', 'jasa', 'standard',  25000, 100 FROM dual UNION ALL
    SELECT 112, 'cetak banner', 'jasa', '1m x 1m',  40000, 100 FROM dual UNION ALL
    SELECT 201, 'kertas hvs a4', 'barang', '1 lembar',  10, 10000 FROM dual UNION ALL
    SELECT 202, 'kertas hvs a4', 'barang', '1 rim',  35000, 1000 FROM dual UNION ALL
    SELECT 203, 'ballpoint', 'barang', '1 pcs',  3500, 1000 FROM dual UNION ALL
    SELECT 204, 'pensil', 'barang', '1 pcs',  2000, 1000 FROM dual UNION ALL
    SELECT 205, 'ballpoint', 'barang', '1 pcs',  3500, 1000 FROM dual UNION ALL
    SELECT 206, 'tipe x', 'barang', '1 pcs',  15000, 1000 FROM dual UNION ALL
    SELECT 207, 'mug 200ml', 'barang', 'uk 300ml',  10000, 1000 FROM dual UNION ALL   
    SELECT 208, 'mug 600ml', 'barang', 'uk 600ml',  15000, 1000 FROM dual UNION ALL
    SELECT 209, 'kaos only', 'barang', 'all size',  50000, 1000 FROM dual;
    
insert into pesanan (id_order, id_product, id_customer, nama_product, detail_product, design_source, order_date, jumlah, total_bayar)
    select 1, 209, 18, 'kaos only', 'all size', NULL, SYSDATE, 80, 4000000 from dual union all 
    select 2, 209, 22, 'kaos only', 'all size', NULL, SYSDATE, 2, 100000 from dual union all
    select 3, 208, 18, 'mug 600ml', 'uk 600ml', NULL, SYSDATE, 100, 1500000 from dual union all
    select 4, 108, 21, 'laminating', 'glossy', 'buku mtk sd', SYSDATE, 20, 60000 from dual;

-- select best buy product

select nama_product, detail_product, order_date,  sum(jumlah)
from pesanan
group by nama_product, order_date, detail_product
order by sum(jumlah) desc;

--Procedure untuk naik gaji
CREATE OR REPLACE PROCEDURE naikgaji
 (p_idpegawai pegawai.id_pegawai%TYPE,
 p_percent_increase decimal)
IS
BEGIN
 UPDATE pegawai
 SET gaji_pegawai = (gaji_pegawai * p_percent_increase) + gaji_pegawai
 WHERE id_pegawai = p_idpegawai;
END naikgaji;

--procedure untuk update stock
CREATE PROCEDURE updatestock
(p_idproduct IN product.stock%TYPE ,pjumlah IN pesanan.jumlah%TYPE)
IS
BEGIN
UPDATE product
SET stock = stock - pjumlah
WHERE id_product = p_idproduct;
END;

--Function

Create or replace function bayar
(p_jumlah IN pesanan.jumlah%TYPE ,p_harga IN product.harga_product%TYPE)
Return  number is
total number(20);
begin
total := p_jumlah*p_harga;
Return total;
end;

CREATE OR REPLACE FUNCTION discount
Return number is
Begin
Return(0.1);
end;

-- Trigger

--Membuat Invoice
create or replace TRIGGER invoice AFTER
INSERT
ON pesanan
FOR EACH ROW
BEGIN
INSERT INTO invoice values(:new.id_order,:new.id_customer,:new.id_product,:new.total_bayar);    
END;

--menampilkan data yang telah terjual
create or replace TRIGGER datapenjualan AFTER
INSERT
ON pesanan
FOR EACH ROW
BEGIN
INSERT INTO datapenjualan values(:new.id_order,:new.id_product,:new.nama_product,:new.jumlah,:new.order_date);    
END;
