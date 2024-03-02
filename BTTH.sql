----TH1:
CREATE DATABASE smallWorks
ON PRIMARY
(
    NAME = smallWorks,
    FILENAME = 'D:\HQTDL\smallWorks.mdf',
    SIZE = 10MB,
    MAXSIZE = 50MB,
    FILEGROWTH = 20%
)
,FILEGROUP SWUserData1
(
    NAME = SWUserData1,
    FILENAME = 'D:\HQTDL\smallWorkData1.mdf',
    SIZE = 10MB,
    MAXSIZE = 50MB,
    FILEGROWTH = 20%
)
,FILEGROUP SWUserData2
(
    NAME = SWUserData2,
    FILENAME = 'D:\HQTDL\smallWorkData2.mdf',
    SIZE = 10MB,
    MAXSIZE = 50MB,
    FILEGROWTH = 20%
)
LOG ON
(
    NAME = smallWorks_log,
    FILENAME = 'D:\HQTDL\smallWorks_log.ldf',
    SIZE = 10MB,
    MAXSIZE = 20MB,
    FILEGROWTH = 10%
);

--use smallWorks
-- table
CREATE TABLE Person 
(
	PersonIN INT NOT NULL,
	FirstName Varchar(50) NOT NULL,
	MiddleName Varchar(50) NULL, 
	LastName Varchar(50) NOT NULL,
	EmailAddress nvarchar(50) NOT NULL
)
ON SWUserData1

Create table Product
(
	ProductID INT NOT NULL,
	ProductName varchar(75) NOT NULL,
	ProductNumber nvarchar(25) NOT NULL,
	StandardCost money NOT NULL,
	ListPrice money NOT NULL
)
ON SWUserData2



----TH2:
CREATE DATABASE QLBH
ON PRIMARY
(
    NAME = QLBH,
    FILENAME = 'D:\HQTDL\qlbh.mdf',
    SIZE = 50MB,
    MAXSIZE = 200MB,
    FILEGROWTH = 10MB
)
LOG ON
(
    NAME = qlbh_log,
    FILENAME = 'D:\HQTDL\qlbh.ldf',
	SIZE = 100MB,
	FILEGROWTH = 20MB,
	MAXSIZE = unlimited
)

--table
CREATE TABLE SANPHAM
(
    MaSP Char(6) NOT NULL PRIMARY KEY,
    TenSP Varchar(20) NOT NULL,
    NgayNhap Date NOT NULL,
    DVT Char(10) NULL,
    SLTon Int NULL,
	DonGiaN money
)

CREATE TABLE KHACHHANG
(
    MaKH Char(6) NOT NULL PRIMARY KEY,
    TenKH nVarchar(30) NOT NULL,
    DiaChi Nvarchar(50) NULL,
    DienThoai Char(12) NOT NULL
)

CREATE TABLE HOADON
(
    MaHD Char(10) NOT NULL PRIMARY KEY,
    NgayLap Date NOT NULL,
    NgayGiao Date NULL,
    MaKH Char(6) NULL FOREIGN KEY REFERENCES KHACHHANG(MaKH),
    DienGiai Varchar(100) NULL
)

CREATE TABLE CHITIETHD
(
    MaHD Char(10) NOT NULL FOREIGN KEY REFERENCES HOADON(MaHD),
    MaSP Char(6) NOT NULL FOREIGN KEY REFERENCES SANPHAM(MaSP),
    SoLuong Int NOT NULL,
    PRIMARY KEY (MaHD, MaSP)
)
