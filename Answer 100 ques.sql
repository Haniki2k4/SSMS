USE S_P_SP	
GO

CREATE TABLE NhanVien(
	MaNV CHAR(5) NOT NULL,
	HoTen VARCHAR(30) NOT NULL,
	NgaySinh DATETIME,
	DiaChi VARCHAR(100) default 'Hanoi',
	Phai CHAR(3),
	MaPhong CHAR(5),
	Luong REAL,
	PRIMARY KEY	(MaNV)
);

CREATE TABLE TinhLuong(
	MaNV CHAR(5) NOT NULL,
	NgayTinhLuong DATETIME NOT NULL, 
	HSLuong CHAR(3),
	SoNgayCong SMALLINT,
	LuongThang real,
	Thuong REAL,
	TongLuong REAL,
	PRIMARY KEY (MaNV,NgayTinhLuong)
);

--CHỈ RA CỘT MaNV TRONG BẢNG TinhLuong LÀ KHÓA NGOẠI THAM CHIẾU ĐẾN CỘT MaNV TRONG BẢNG NhanVien
ALTER TABLE TinhLuong
ADD CONSTRAINT FK_TinhLuong FOREIGN KEY(MaNV)
REFERENCES NhanVien(MaNV)

--BỔ SUNG CỘT MaDV VÀO BẢNG NhanVien
ALTER TABLE NhanVien
ADD MaDV CHAR(5) NOT NULL

--XÓA CỘT MaDV TRONG BẢNG NhanVien
ALTER TABLE NhanVien
DROP COLUMN MaDV --(VỚI CỘT CÓ RÀNG BUỘC THÌ CẦN CÓA TẤT CẢ CÁC RÀNG BUỘC LQUAN TRC)

--THAY ĐỔI KDL CHO CỘT Thuong TRONG BẢNG TinhLuong TỪ REAL SANG INT
ALTER TABLE TinhLuong
ALTER COLUMN Thuong INT

--XÓA BẢNG TinhLuong (CẦN XÓA TẤT CẢ CÁC RẰNG BUỘC TRC KHI XOA BẢNG)
ALTER TABLE TinhLuong
DROP CONSTRAINT FK_TinhLuong
DROP TABLE TinhLuong

--THÊM CỘT MaNQL TRONG BẢNG NhanVien
ALTER TABLE NhanVien
ADD MaNQL CHAR(5) NOT NULL /*LENGTH MaNQL phải bằng LENGTH MaNV, DATATYPE = DATATYPE*/

--THÊM RÀNG BUỘC TOÀN VẸN(RBTV) MaNQL THAM CHIẾU ĐẾN MaNV
ALTER TABLE NhanVien
ADD CONSTRAINT FK_NhanVien FOREIGN KEY(MaNQL) REFERENCES NhanVien(MaNV)

--XÓA RBTV MaNQL NÓI TRÊN
ALTER TABLE NhanVien
DROP CONSTRAINT FK_NhanVien

--XÓA CỘT MaNQL
ALTER TABLE NhanVien
DROP COLUMN MaNQL

--TẠO BẢNG PhongBan VÀ TẠO CÁC RÀNG BUỘC: PK, Unique, FK
CREATE TABLE Phongban(
	MaPhong CHAR(10),
	TenPhong VARCHAR(100),
	TruongPhong CHAR(5),
	CONSTRAINT PK_Phongban PRIMARY KEY (MaPhong),
	CONSTRAINT U_Phongban UNIQUE (TenPhong),
	CONSTRAINT FK_Phongban FOREIGN KEY (TruongPhong) REFERENCES NhanVien(MaNV)
 );

--XÓA BẢNG PhongBan
DROP TABLE Phongban

------------------S P SP-----------------
/*S: nhà cung cấp
  P: sản phẩm
  SP: dsach các mặt hàng đã bán

S(SID, Sname, Status, City);
P (PID, Pname, Color, Weight);
SP(SID, PID, Qty, SDate);
*/

--đưa ra PID (mã các mặt hàng đã bán)
SELECT PID FROM S_P_SP.dbo.SP

--ĐƯA RA PID KHÔNG TRÙNG LẶP
SELECT DISTINCT PID FROM S_P_SP.dbo.SP

--CHO BIẾT MÃ HIỆU SID & SỐ LƯỢNG CÁC MẶT HÀNG ĐÃ BÁN
SELECT SID,Quantity FROM S_P_SP.dbo.SP

--CHO BIẾT MÃ SỐ PID CÁC MẶT HÀNG KHÁC NHAU ĐÃ BÁN
SELECT DISTINCT PID FROM SP

--SỬ DỤNG * ĐỂ HIỆN THỊ TẤT CẢ CÁC DÒNG, CỘT BẢNG SP
SELECT * FROM SP

--TÌM MÃ SỐ SID CỦA CÁC HÃNG ĐÃ BÁN MẶT HÀNG P2
SELECT SID FROM SP WHERE PID = 'P2'

--TÌM MÃ SỐ SID CỦA CÁC HÃNG ĐÃ CUNG CẤP CÁC MẶT HÀNG CÓ SỐ LƯỢNG GIỮA 10 VÀ 20
SELECT SID FROM SP WHERE Quantity >= 10 AND Quantity <= 20

--ĐƯA RA TTIN HÃNG CUNG ỨNG CÓ TÊN Sant HAY San
SELECT Sname FROM S WHERE Sname LIKE '%San%'
/*
	A%B:XÂU BẮT ĐẦU = 'A' VÀ KẾT THÚC = 'B'
	%A: XÂU BẤT KỲ KẾT THÚC BẰNG 'A'
	A_B:KÝ TỰ THỨ 2 LÀ BẤT KỲ
*/
--ĐƯA RA THÔNG TIN HÃNG CUNG ỨNG CÓ TÊN KẾT THÚC LÀ 'ikes'
SELECT Sname FROM S WHERE Sname LIKE '%ikes' 

--ĐƯA RA Sname CỦA CÁC HÃNG ĐÃ BÁN MẶT HÀNG 'P2'
SELECT Sname FROM S,SP WHERE (S.SID = SP.SID) AND (PID = 'P2')

--ĐỔI TÊN CỘT Sname THÀNH Tennhacungcap 
SELECT Sname AS Tennhacungcap FROM S,SP 
WHERE S.SID = SP.SID AND PID='P2'

--ĐƯA RA TÊN VÀ ĐỊA CHỈ CỦA CÁC HÃNG CUNG ỨNG CÓ Status > 100
SELECT Sname,City FROM S WHERE Status >100 

--ĐƯA RA SID CỦA CÁC HÃNG ĐÃ BÁN CẢ 2 MẶT HÀNG P1 VÀ P2
SELECT T1.SID FROM SP AS T1, SP AS T2
WHERE ((T1.SID = T2.SID) AND (T1.PID = 'P1') AND (T2.PID = 'P2'))

/*ORDER BY: SẮP XẾP
	ASC: TĂNG DẦN
	DESC: GIẢM DẦN
*/

--TÌM Pname VÀ PID CỦA CÁC MẶT HÀNG MÀU ĐỎ SẮP XẾP THEO THỨ TỰ GIẢM DẦN CỦA PID
SELECT Pname, PID FROM P WHERE Color ='red' ORDER BY PID DESC

/*tìm kiếm nhờ GROUP BY <dsach cột> [HAVING<điều kiện>]*/
--TÌM SID CUNG CẤP CẢ 2 MẶT HÀNG P1 VÀ P2
SELECT SID FROM SP WHERE PID IN ('P1', 'P2') GROUP BY SID

--TÌM SID BÁN ÍT NHẤT 2 MẶT HÀNG
SELECT SID FROM SP GROUP BY SID HAVING COUNT(PID)>=2

/*PHÉP TOÁN TẬP HỢP UNION, INTERSECT, EXCEPT (hợp, giao, trừ)*/
--CHO BIẾT SID CÁC HÃNG CHƯA CUNG ỨNG MẶT HÀNG NÀO
SELECT SID FROM SP EXCEPT SELECT SID FROM SP

--SỬ DỤNG TOÁN TỬ IN, TIM SID & Sname CÁC HÃNG ĐÃ BÁN MẶT HÀNG P2
SELECT SID, Sname FROM S WHERE SID IN(SELECT SID FROM SP WHERE PID = 'P2')

--ĐƯA RA Sname CỦA CÁC HÃNG CÓ STATUS LÀ LỚN NHẤT
SELECT Sname,Status FROM S WHERE Status >= ALL(SELECT Status FROM S)

--ĐƯA RA DÁNH SÁCH CHƯA BÁN MẶT HÀNG NÀO
SELECT * FROM S WHERE SID <> ALL (SELECT SID FROM SP)

--ĐƯA RA Sname CỦA CÁC HÃNG ĐÃ BÁN ÍT NHẤT 1 MẶT HÀNG NÀO ĐÓ
SELECT Sname FROM S WHERE EXISTS (SELECT * FROM SP WHERE SP.SID = S.SID)

--TÍNH TRỌNG LƯỢNG TRUNG BÌNH CỦA CÁC MẶT HÀNG MÀU ĐỎ
SELECT AVG(Weight) FROM P WHERE Color = 'red'

--VỚI MỖI HÃNG CUNG ỨNG, ĐƯA RA SID VÀ ĐẾM SID BÁN BAO NHIÊU MẶT HÀNG
SELECT SID, COUNT(DISTINCT PID) AS NumProducts FROM SP GROUP BY (SID)  

--ĐƯA RA THÔNG TIN VỀ 3 LẦN BÁN HÀNG ĐẦU TIÊN
SELECT TOP 3 Sdate FROM SP 

--THÊM CỘT Price, Tax VÀO SP(SAU ĐÓ NHẬP VALUE TƯƠNG ỨNG)
ALTER TABLE SP
ADD Price REAL,Tax REAL

--ĐƯA RA MÃ NHÀ CUNG CẤP, MÃ MẶT HÀNG, SỐ LƯỢNG BÁN, GIÁ BÁN, THÀNH TIỀN(TT=GB*SL)
SELECT SID,PID,Quantity,Price, Quantity*Price AS Amount FROM SP
--SỬ DỤNG AS ĐỂ ĐỔI TÊN GỢI NHỚ CÁC CỘT TRÊN
SELECT SID AS BENCUNGCAP,
PID AS MAMATHANG,
Quantity AS Soluong,
Price AS GIA,
Quantity*Price AS THANHTIEN FROM SP 

--TÍNH TỔNG DOANH THU
SELECT SUM(Price) FROM SP

--ĐẾM SỐ LẦN BÁN HÀNG
SELECT COUNT(*) FROM SP

--XEM THÔNG TIN BÁN HÀNG TRONG NGÀY 03/10/2022
SELECT * FROM SP WHERE CONVERT(NVARCHAR,Sdate,103) = '03/10/2022'

--XEM THÔNG TIN VỀ CÁC SẢN PHẨM CÓ GIÁ TỪ 16 ĐẾN 18
SELECT * FROM SP WHERE Price BETWEEN 16 AND 18

--SỬ DỤNG TOÁN TỬ OR, SHOW CÁC LẦN BÁN SẢN PHẨM P1 HOẶC P2 HOẶC P3
SELECT * FROM SP WHERE PID = 'P1' OR PID = 'P2' OR PID = 'P3'

--TOÁN TỬ IN, SHOW CÁC LẦN BÁN SẢN PHẨM P1 HOẶC P2 HOẶC P3
SELECT * FROM SP WHERE PID IN ('P1','P2','P3')

--ĐƯA RA CÁC HÃNG CUNG ỨNG CÓ ĐỊA CHỈ BẮT ĐẦU BẰNG 3
SELECT * FROM S WHERE City LIKE '3%' 

--XEM THÔNG TIN VỀ LẦN BÁN CHẠY NHẤT CỦA SẢN PHẨM (SỐ LƯỢNG)
SELECT * FROM SP WHERE Quantity = (SELECT MAX(Quantity) FROM SP)

--ĐƯA RA MÃ VÀ TỔNG SỐ LƯỢNG ĐÃ BÁN CỦA TỪNG SẢN PHẨM
SELECT PID,SUM(Quantity) FROM SP GROUP BY PID 

--SẮP XẾP CÁC SẢN PHẨM THEO THỨ TỰ TĂNG DẦN Amount 
SELECT Quantity*Price AS Amount FROM SP ORDER BY  Quantity*Price ASC

--HIỆN THỊ TTIN BÁN HÀNG SID, Sdate, Quantity THEO TỪNG HÃNG CUNG CẤP
SELECT SID,Sdate,Quantity FROM SP GROUP BY SID,Sdate,Quantity

--CHO BIẾT MÃ SỐ NHỮNG NHÀ CUNG CẤP MẶT HÀNG P1 VÀ P2
SELECT SID FROM SP WHERE PID = 'P1' INTERSECT SELECT SID FROM SP WHERE PID = 'P2'

--ĐƯA RA MÃ VÀ TÊN CÁC NHÀ CUNG CẤP ĐÃ BÁN MẶT HÀNG P1
SELECT S.SID,Sname FROM S,SP WHERE (S.SID = SP.SID) AND PID = 'P1'

--LIỆT KÊ NHỮNG LẦN BÁN HÀNG KO TÍNH THUẾ
SELECT * FROM SP WHERE Tax IS NULL

--Cho biết số lần bán mặt hàng P2 :
SELECT COUNT(*) AS SoLuongP2 FROM SP WHERE PID = 'P2' 

--Tính hiệu số giữa lần bán nhiều nhất và lần bán ít nhất của mặt hàng P2 ?
SELECT Max(Quantity)-Min(Quantity) AS HiệuSốMaxMin FROM SP WHERE PID='P2'

--Tìm những mã mặt hàng bán trước ngày 06/08/2022 một ngày
SELECT PID FROM SP WHERE DateDiff(d, Sdate, '2022-08-06') = 1


