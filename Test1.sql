/*
Câu 2.
Chứng minh luật Hợp (Union) trong hệ tiên đề Amstrong.

Câu 3.
Cho lược đồ quan hệ R(M, N, P, X, Y, Z, W) và tập phụ thuộc hàm 
S={MN→PX, MZ→X, XY →Z, P→W, Z→Y, W→M}
Hãy tính bao đóng (Closure-set): {PZ}+.

Câu 4. Viết lệnh SQL (6 đ)
Trên một cơ sở dữ liệu quan hệ có ba bảng sau:
1. S(SID, Sname, Addr, Status);
2. P(PID, Pname, Color, Ingredients);
3. SP(SID, PID, Price, Qty, Sdate); 
trong đó:
S: Suppliers - các hãng cung ứng dược phẩm; 
P: Products - các mặt hàng/dược phẩm; 
SP: Suppliers_Products: thông tin bán hàng (dược phẩm đã cung ứng).
SID: Mã nhà cung ứng; Sname: tên nhà cung ứng; Addr: Địa chỉ nhà cung ứng; 
Status: Hiện trạng (số lượng tồn kho);
PID: Mã mặt hàng; Pname: Tên mặt hàng; Ingredients: Thành phần; Color: 
Màu sắc;
Price: Đơn giá; Qty (quantity): Số lượng bán; Sdate: Ngày bán;
Viết lệnh SQL trả lời các câu hỏi:
1. Tìm mã số (SID) của các hãng đã bán mặt hàng „P8‟.
2. Tìm mã số SID của các hãng đã cung cấp các mặt hàng có số lượng giữa 3 và 
30.
3. Tìm SID bán ít nhất năm mặt hàng.
4. Cho biết SID các hãng chưa bán mặt hàng nào.
5. Tạo View có tên View3 chứa dữ liệu bán hàng của hãng „S3‟.
6. Đưa ra mã sản phẩm có tổng số lượng bán được ít nhất.
*/


Bài làm
Câu 1:

CREATE DATABASE KHDL1;
USE KHDL1;
CREATE TABLE Agent (
aName varchar(255)NOT NULL,
cName varchar(255)NOT NULL,
city varchar(255),
phone varchar(12),
Primary Key (aName,cName)
);

CREATE TABLE Presenter (
aName varchar(255)NOT NULL,
cName varchar(255)NOT NULL,
SIN int NOT NULL, 
 fname varchar(255),
Iname varchar(255),
 hair varchar(255),
 PRIMARY KEY (SIN),
 FOREIGN KEY (aName,cName) REFERENCES Agent(aName,cName)
);

CREATE TABLE Prodcomp (
pcName varchar(255) NOT NULL,
network varchar(255),
country varchar(255),
Primary Key (pcName)
);

CREATE TABLE Show (
pcName varchar(255) NOT NULL,
sName varchar(255) NOT NULL, 
 station varchar(255),
season varchar(255),
 PRIMARY KEY (sName),
 FOREIGN KEY (pcName) REFERENCES Prodcomp(pcName)
);

CREATE TABLE presents (
SIN int NOT NULL,
sName varchar(255) NOT NULL,
times time,
rating varchar(255),
 FOREIGN KEY (sName) REFERENCES Show(sName),
FOREIGN KEY (SIN) REFERENCES Presenter(SIN)
);


Câu 2:
Luật Hợp (Union) trong hệ tiên đề Armstrong nói rằng: nếu X → Y và X → Z thì X → YZ. 
Đây là một trong những quy tắc cơ bản của hệ tiên đề Armstrong, bên cạnh các quy tắc khác như Tính phản xạ, Tính tăng trưởng và Tính bắc cầu. 
Để chứng minh luật Hợp, ta có thể sử dụng các quy tắc khác trong hệ tiên đề Armstrong. Giả sử ta có X →Y và X → Z. Ta muốn chứng minh X → YZ. 
Do X → Y và X → Z, ta áp dụng quy tắc Tăng trưởng (Augmentation) với Z để có XZ → YZ. 
Do X → Z, ta áp dụng quy tắc Phản xạ (Reflexivity) để có XZ → X. 
Kết hợp hai kết quả trên bằng quy tắc Bắc cầu (Transitivity), ta có X → YZ. 
Vậy, ta đã chứng minh được luật Hợp trong hệ tiên đề Armstrong. 

Câu 3:
Hãy tính bao đóng của {PZ}+: {PZ}+ = {MPXYZW}+
{PZ}+ → {PYZW}+
{PYZW}+ → {MPYZW}+
{MPYZW}+ → {MPXYZW}+ 

Câu 4:
1. SELECT *,SID FROM SP WHERE PID = 'P8'
2. SELECT *,SID FROM SP WHERE Quantity BETWEEN 3 AND 30
3. SELECT SID FROM SP GROUP BY SID HAVING COUNT(SP.PID) >= 5
4. SELECT SID FROM S EXPECT SELECT SID FROM SP
5. CREATE VIEW View3 AS SELECT * FROM SP WHERE SID = 'S3'
6. SELECT top 1 PID,SUM(Quantity) AS TongBan FROM SP GROUP BY
PID ORDER BY SUM(Quantity) AS
