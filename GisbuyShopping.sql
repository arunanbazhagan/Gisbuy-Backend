 create database GisbuyShopping
use GisbuyShopping
drop table UsernameTable
create table UsernameTable(
 customer_name varchar(255),
 customer_ph varchar(255),
 customer_add varchar(255),
 customer_email varchar(100),
 customer_pass varchar(100)
)
drop table UsernameTable












select * from payment_table
update UsernameTable set customer_ph='8985700473' where customer_email='harsha.kondaiahgari@gmail.com'
insert into UsernameTable values('Arun Anand','7373287424','23 Krishna street','arunanand307@gmail.com','1234')
update UsernameTable set customer_pass='4321'where customer_email='ams@gmail.com'
insert into UsernameTable values('Tamil Arasi','7373287525','23 Kamaraj street','thanvi@gmail.com','4321')
insert into UsernameTable values('khadhiri','7654321','jeevanagar','ams@gmail.com','4321')

create proc proc_Register(@cus_name varchar(255),@cus_ph varchar(20),@cus_add varchar(255),@cus_email varchar(255),@cus_pass varchar(20))
as
begin
insert into UsernameTable values(@cus_name,@cus_ph,@cus_add,@cus_email,@cus_pass)  
end
delete from UsernameTable where customer_email='harsha.kondaiahgari@gmail.com'
create proc proc_FetchUser(@customer_email varchar(255))
as
begin
select customer_email from UsernameTable where customer_email=@customer_email
end
delete from statustable where email='harsha.kondaiahgari@gmail.com'
create proc proc_UserLogin(@customer_email varchar(30),@customer_pass varchar(30))
as
begin
select * from UsernameTable where customer_email = @customer_email AND customer_pass=@customer_pass
end
exec proc_UserLogin 'arunanand307@gmail.com','43123421'

create proc proc_Adminforget(@adminid varchar(200),@adminemail varchar(200),@adminpass varchar(200))
as
begin
update AdminTable set AdminPass=@adminpass where AdminId=@adminid and AdminEmail=@adminemail
end

create proc proc_ForgotPassword(@customer_email varchar(255),@customer_pass varchar(255),@customer_ph varchar(255))
as
begin
update UsernameTable set customer_pass=@customer_pass where customer_email=@customer_email and customer_ph=@customer_ph
end

select * from UsernameTable

exec proc_ForgotPassword 'arunanand307@gmail.com','4321','7377287424'

select * from statustable
select * from AdminTable
create proc proc_product
as
begin
select * from Product_Table
end
drop table OrderTable
select * from OrderTable
alter proc proc_ordercount(@Customer_email varchar(200))
as
begin
select count(email)as count from OrderTable where email=@Customer_email 
end
select * from OrderTable where email='ams@gmail.com'
create proc proc_OrderDetails(@Customer_email varchar(255))
as
begin
select * from OrderTable where email=@Customer_email
end
select * from OrderTable
create table OrderTable(ord_id int IDENTITY(100,1),email varchar(255),prod_id varchar(255),
prod_name varchar(255),price float,image varchar(255),quantity int)
create proc proc_AddtoCart(@customer_email varchar(200),@prod_id varchar(255),@prod_name varchar(100),@prod_price float,@image varchar(255),@quantity int)
as
declare @khathiri int,@price int
set @khathiri = 0
begin
IF EXISTS (select * from OrderTable where prod_id=@prod_id and email=@customer_email)
begin
select @khathiri = (select quantity from OrderTable where prod_id=@prod_id and email=@customer_email)
select @khathiri = @khathiri+1
select @price = (select Price from Product_Table where Product_Id=@prod_id) 
update OrderTable set quantity=@khathiri,price=@price*@khathiri where prod_id=@prod_id
end
else
begin
set @quantity = @khathiri+1
insert into OrderTable values(@customer_email,@prod_id,@prod_name,@prod_price,@image,@quantity ) 
end
end
select * from proc_search

create proc pro_type(@type varchar(200))
as
begin
select * from Product_Table where Product_Type=@type
end
exec pro_type 'Toys'
alter proc proc_search(@prod_name varchar(100))
as
begin
select * from  Product_Table where Product_Name like '%'+@prod_name+'%' or Category like '%' +@prod_name+'%' or Product_Type like '%'+@prod_name+'%' ORDER BY Price ASC
end
exec proc_search 'sa'
drop table Product_Table
create table Product_Table(Id int identity ,Product_Id AS 'P'+RIGHT('0000'+CAST(Id AS VARCHAR(10)),4),Product_Name varchar(100),Category varchar(50),Product_Type varchar(50),
Description_1 varchar(600),Description_2 varchar(600),Description_3 varchar(600),Description_4 varchar(600),
Description_5 varchar(600),Price float,Quantity int,Image varchar(400))
select * from payment_table
create table payment_table(pay_id int IDENTITY(100,1),ord_id varchar(255),prod_id varchar(255),
prod_name varchar(200),prod_price varchar(255),image varchar(255),quantity int) 
create proc proc_Makepayment(@ord_id int ,@prod_id varchar(100),@prod_price varchar(20),@prod_name varchar(200),@image varchar(255),@quantity int)
as
begin
insert into payment_table values(@ord_id,@prod_id,@prod_price,@prod_name,@image,@quantity)
end
create proc proc_corder(@ord_id int)
as
begin
delete from payment_table where ord_id=@ord_id
end

create proc proc_cancelorder(@ord_id int)
as
begin
delete from OrderTable where ord_id=@ord_id
end
alter proc proc_canorder(@statusid int)
as
declare @quantity int
begin
select @quantity = (select quantity from statustable where status_id = @statusid)
update Product_Table set Quantity = Quantity + @quantity where Product_Id = (select prod_id from statustable where status_id=@statusid)
update statustable set stage='Cancel' where status_id=@statusid

end
exec proc_canorder 118

select * from Product_Table
select * from payment_table
select * from  statustable
select * from statustable
create table statustable(status_id int IDENTITY(100,1),stage varchar(255),email varchar(255),
prod_id varchar(255),prod_name varchar(255),prod_price varchar(255),payment_type varchar(255),Name varchar(200),
address varchar(255),pincode varchar(255),phone_number varchar(200),image varchar(200),quantity int)
select * from statustable
create proc proc_Placeorder(@ord_id int,@prod_name varchar(255),@prod_price float,@prod_id varchar(255),@email varchar(255),@paymenttype varchar(255),@name varchar(200),@address varchar(255),@pincode varchar(255),@phone_number varchar(200),@image varchar(200),@quantity int)
as
begin
insert into statustable values('Ordered',@email,@prod_id,@prod_name,@prod_price,@paymenttype,@name,@address,@pincode,@phone_number,@image,@quantity)
update Product_table set Quantity=Quantity-@quantity where Product_Id=@prod_id 
delete ordertable where ord_id=@ord_id
end

select * from statustable
create table AdminTable(
AdminId varchar(200),
AdminPass varchar(200),
Adminemail varchar(200))
select * from AdminTable
drop table AdminTable
insert into AdminTable values('2178','1234','arun.anbazhagan@kanini.com')
insert into AdminTable values('2164','4321','vishnu.nagarajan@kanini.com')

create proc proc_AdminLogin(@adminid varchar(200),@adminpass varchar(200))
as
begin
select * from AdminTable where AdminId=@adminid and AdminPass=@adminpass
end
create proc pro_DeleteProduct(@pro_id varchar(200))
as
begin
delete from Product_Table where Product_Id=@pro_id
end
select * from Product_Table
update Product_Table set Product_Type='Dry Fruits' where Product_Type='Dry Fruits,Nuts & Seeds'
create proc proc_Addproduct(@prod_name varchar(200),@category varchar(200),@product_type varchar(200),
@description1 varchar(255),@description2 varchar(255),@description3 varchar(255),@description4 varchar(255),@description5 varchar(255),
@price float,@Quantity int,@Image varchar(255))
as
begin 
insert into Product_Table values(@prod_name,@category,@product_type,@description1,@description2,@description3,@description4,@description5,@price,@Quantity,@Image)
end
alter proc proc_UpdateProduct(@product_id varchar(200),@prod_name varchar(200),@category varchar(200),@product_type varchar(200),@description1 varchar(200),@description2 varchar(200),@description3 varchar(200),@description4 varchar(200),@description5 varchar(200),
@Price float,@Quantity int,@Image varchar(200))
as
begin
update Product_Table set  Product_Name=@prod_name,Category=@category,Product_Type=@product_type,Description_1=@description1,
Description_2=@description2,Description_3=@description3,Description_4=@description4,Description_5=@description5,Price=@Price,Quantity=@Quantity,Image=@Image where Product_Id=@Product_Id
end

create proc proc_GetData(@pro_id varchar(200))
as
begin
select * from Product_Table where Product_Id=@pro_id
end

create proc proc_FetchId(@proid varchar(200))
as
begin
select * from Product_Table where Product_Id=@proid
end
create proc proc_yourorder(@Customer_email varchar(200))
as
begin
select * from statustable where email=@Customer_email
end

create proc proc_GetCancelData(@statusid int)
as
begin
select * from statustable where status_id=@statusid
end

select * from statustable
select * from payment_table
select * from Product_Table
insert into Product_Table values ('realme 5','Electronics','Mobile',
'Memory: 3 GB RAM | 32 GB ROM | Expandable Upto 256 GB',
'Display: 16.51 cm (6.5 inch) HD+ Display',
'Camera: 12MP + 8MP + 2MP + 2MP | 13MP Front Camera',
'Battery: 5000 mAH Battery',
'Processor: Qualcomm Snapdragon 665 2 GHz Processor',
'8999',10,'assets/P001.jpeg')

insert into Product_Table values('Redmi 8','Electronics','Mobile',
'Memory: 4 GB RAM | 64 GB ROM | Expandable Upto 512 GB',
'Display: 15.8 cm (6.22 inch) HD+ Display',
'Camera: 12MP + 2MP | 8MP Front Camera',
'Battery: 5000 mAh Battery',
'Processor: Qualcomm Snapdragon 439 Processor',
'7999',15,'assets/P002.jpeg')


insert into Product_Table values('OPPO Reno2 F','Electronics','Mobile',
'Memory: 8 GB RAM | Expandable upto 128 GB ROM ',
'Display: 16.51 cm (6.5 inch) Display',
'Camera: 48MP + 8MP + 2MP + 2MP | 16MP Front Camera',
'Battery: 4000 mAh Battery',
'Processor: MTK MT6771V(P70) 64bit Processor','23990',12,
'assets/P003.jpeg')


insert into Product_Table values('Apple iPhone 7','Electronics','Mobile',
'Memory: 3GB RAM |32 GB ROM ',
'Display:11.94 cm (4.7 inch) Retina HD Display',
'Camera: 12MP Rear Camera | 7MP Front Camera',
'Battery: Non-removable Li-Ion 1960 mAh battery ',
'Processor: Apple A10 Fusion 64-bit processor and Embedded M10 Motion Co-processor','24999',14,
'assets/P004.jpeg')
--------------------------------------------------------

insert into Product_Table values('realme XT','Electronics','Mobile',
'Memory: 4 GB RAM | 64 GB ROM | Expandable Upto 256 GB',
'Display: 16.26 cm (6.4 inch) Display',
'Camera: 64MP + 8MP + 2MP + 2MP Quad Camera | 16MP Front Camera',
'Battery: 4000 mAh Battery',
'Processor: Qualcomm 712 Processor','15999',15,
'assets/P005.jpeg')


insert into Product_Table values('realme 5 pro','Electronics','Mobile',
'Memory: 6 GB RAM | 64 GB ROM | Expandable Upto 256 GB',
'Display: 16.0 cm (6.3 inch) FHD+ Display',
'Camera: 48MP + 8MP + 2MP + 2MP Quad Camera | 16MP Front Camera',
'Battery: 4035 mAh Battery',
'Processor: Qualcomm Snapdragon SDM712 Octa Core 2.3 GHz Processor','13999',16,
'assets/P006.jpeg')


insert into Product_Table values('Infinix Hot 8','Electronics','Mobile',
'Memory: 4 GB RAM | 64 GB ROM ',
'Display: 16.56 cm (6.52 inch) HD+ Display',
'Camera: 13MP + 2MP + Low Light Sensor | 8MP Front Camera',
'BBattery: 5000 mAh Li-ion Polymer Battery',
'Processor: Helio P22 (MTK6762) Processor','6999',16,
'assets/P007.jpeg')


insert into Product_Table values('Lenovo K10 Plus','Electronics','Mobile',
'Memory: 4 GB RAM | 64 GB ROM | Expandable Upto 2 TB',
'Display: 15.8 cm (6.22 inch) HD+ Display',
'Camera: 13MP + 5MP + 8MP | 16MP Front Camera',
'Battery: 4050 mAh Battery',
'Processor: Qualcomm SDM632 Processorr','10999',16,
'assets/P008.jpeg')


insert into Product_Table values('Asus ROG Phone II','Electronics','Mobile',
'Memory: 8 GB RAM | 128 GB ROM ',
'Display: 16.74 cm (6.59 inch) FHD+ Display',
'Camera: 48MP + 13MP | 24MP Front Camera',
'Battery: 6000 mAh Battery',
'Processor: Qualcomm Snapdragon 855 Plus Processor','37999',16,
'assets/P009.jpeg')


insert into Product_Table values('Redmi K20','Electronics','Mobile',
'Memory: 6 GB RAM | 64 GB ROM ',
'Display: 16.23 cm (6.39 inch) FHD+ Display',
'Camera: 48MP + 13MP + 8MP | 20MP Front Camera',
'Battery: 4000 mAh Li-polymer Battery',
'Processor: Qualcomm Snapdragon 730 Processor','19999',16,
'assets/P010.jpeg')


insert into Product_Table values('Asus ZenBook Core i5 8th Gen','Electronics','Laptops',
'intel Core i5 Processor(8th Gen) ',
'8GB DDR4 RAM 1 TB HDD',
'64 bit Windows 10 Operating System',
'35.56 cm (14 inch) 1920 x 1080 Pixel',
'Light Laptop without Optical Disk Drive','42990',16,
'assets/P011.jpeg')


insert into Product_Table values('Asus Core i3 7th Gen','Electronics','Laptops',
'Intel Core i3 Processor(7th Gen',
'4GB DDR4 RAM 1TB HDD ',
'64 bit Windows 10 Operating System',
'39.62 cm(15.6 inch) Display',
'Light Laptop without Optical Disk Drive','23990',16,
'assets/P012.jpeg')


insert into Product_Table values('Acer Swift 3 Core i5 8th Gen','Electronics','Laptops',
'Intel Core i5 Processor(8th Gen',
'8 GB DDR4 RAM 512GB SSD',
'64 bit Windows 10 Operating System',
'35.56 cm(14 inch) Display',
'Light Laptop without Optical Disk Drive','47990',16,
'assets/P013.jpeg')


insert into Product_Table values('Acer Aspire 3 Ryzen 3 Dual Core','Electronics','Laptops',
'AMD Ryzen 3 Dual Core Processor',
'4 GB DDR$ RAM 1 TB HDD',
'64 bit Windows 10 Operating System',
'39.62 cm(15.6 inch) Display',
'Light Laptop without Optical Disk Drive','21990',16,
'assets/P014.jpeg')


insert into Product_Table values('Lenovo Ideapad 130 Core i3 7th Gen','Electronics','Laptops',
'Intel Core i3 Processor(7th Gen)',
'4 GB DDR4 RAM 1 TB HDD',
'64 bit Windows 10 Operating System',
'39.62 cm(15.6 inch) Display',
'Light Laptop without Optical Disk Drive','26990',16,
'assets/P015.jpeg')


insert into Product_Table values('Lenovo Ideapad L340 Core i5 8th Gen','Electronics','Laptops',
'Intel Core i5 Processor(8th Gen)',
'8 GB DDR8 RAM 1 TB HDD',
'64 bit Windows 10 Operating System',
'39.62 cm(15.6 inch) Display',
'Light Laptop without Optical Disk Drive','39990',16,
'assets/P016.jpeg')


insert into Product_Table values('Dell Latitude 3490 Core i5 8th Gen','Electronics','Laptops',
'Intel Core i5 Processor(8th Gen)',
'4 GB DDR4 RAM 1 TB HDD',
'64 bit Windows 10 Operating System',
'35.56 cm(14 inch) Display',
'Light Laptop without Optical Disk Drive','55885',16,
'assets/P017.jpeg')


insert into Product_Table values('Dell Vostro 3000 Core i5 8th Gen','Electronics','Laptops',
'Intel Core i5 Processor(8th Gen)',
'8 GB DDR4 RAM 1 TB HDD',
'64 bit Linux/Ubuntu Operating System',
'35.56 cm(14 inch) Display',
'Light Laptop without Optical Disk Drive','34990',16,
'assets/P018.jpeg')


insert into Product_Table values('HP 14q Core i3 7th Gen','Electronics','Laptops',
'Intel Core i3 Processor(7th Gen)',
'8 GB DDR4 RAM 1 TB HDD',
'64 bit Windows 10 Operating System',
'35.56 cm(14 inch) Display',
'Light Laptop without Optical Disk Drive','31490',16,
'assets/P019.jpeg')


insert into Product_Table values('HP 15 Core i5 8th Gen','Electronics','Laptops',
'Intel Core i3 Processor(7th Gen)',
'8 GB DDR4 RAM 1 TB HDD',
'64 bit Windows 10 Operating System',
'39.62 cm(15.6 inch) Display',
'Light Laptop without Optical Disk Drive','46990',16,
'assets/P020.jpeg')


insert into Product_Table values('Honor Pad 5',
'Electronics','Tablets',
'Memory: 4 GB RAM | 64 GB ROM | Expandable Upto 256 GB ',
'Display: 25.65 cm (10.1 inch) Full HD Display',
'Camera: 8 MP Primary Camera | 2 MP Front',
'Battery: 5100 mAh Lithium Polymer',
'Processor: Kirin 659 (64-bit) Octa Core (4 x Cortex A53 at 2.36 GHz + 4 x Cortex A53 at 1.7 GHz)','18999',16,
'assets/P021.jpeg')


insert into Product_Table values('Honor MediaPad T3',
'Electronics','Tablets',
'Memory: 3 GB RAM | 32 GB ROM | Expandable Upto 128 GB',
'Display: 24.38 cm (9.6 inch) HD Display',
'Camera: 5 MP Primary Camera | 2 MP Front',
'Battery: Battery: 4800 mAh Li-ion Polymer',
'Processor: Qualcomm MSM8917 Quad Core Processor','11999',16,
'assets/P022.jpeg')


insert into Product_Table values('Lenovo Tab 4 10',
'Electronics','Tablets',
'Memory: 2 GB RAM | 16 GB ROM | Expandable Upto 128 GB',
'Display: 25.65 cm (10.1 inch) HD Display',
'Camera: 5 MP Primary Camera | 2 MP Front',
'Battery: Battery: 7000 mAh Lithium Polymer',
'Processor: Qualcomm Snapdragon MSM8917 Quad Core 64-bit Processor','9999',16,
'assets/P023.jpeg')


insert into Product_Table values('Lenovo Tab M10',
'Electronics','Tablets',
'Memory: 3 GB RAM | 32 GB ROM | Expandable Upto 256 GB',
'Display: 25.65 cm (10.1 inch) Full HD Display',
'Camera: 5 MP Primary Camera | 2 MP Front',
'Battery: Battery: 4850 mAh Lithium Polymer',
'Processor: Qualcomm Snapdragon 450 Octa Core Processor','15999',16,
'assets/P024.jpeg')


insert into Product_Table values('Samsung Galaxy Tab A 8.0',
'Electronics','Tablets',
'Memory: 2GB RAM | 32 GB ROM | Expandable Upto 512 GB',
'Display: 20.32 cm (8 inch) Display',
'Camera: 8 Megapixels MP Primary Camera',
'Battery: 5100 mAh lithium-ion',
'Processor: Qualcomm Snapdragon 450 Octa Core Processor','8999',16,
'assets/P025.jpeg')


insert into Product_Table values('Samsung Galaxy Tab A',
'Electronics','Tablets',
'Memory: 3 GB RAM | 32 GB ROM | Expandable Upto 400 GB',
'Display: 26.67 cm (10.5 inch) Full HD Display',
'Camera: 8 MP Primary Camera | 5 MP Front',
'Battery: 7300 mAh Lithium Ion',
'Processor: Qualcomm Snapdragon 450 Octa Core','29990',16,
'assets/P026.jpeg')


insert into Product_Table values('iBall Gorgeo 4GL',
'Electronics','Tablets',
'Memory: 1 GB RAM | 8 GB ROM | Expandable Upto 32 GB',
'Display: 17.78 cm (7 inch) HD Display',
'Camera: 5 MP Primary Camera | 2 MP Front',
'Battery: 3500 mAh Lithium Ion',
'Processor: Processor: ARM Coertex A53','5990',16,
'assets/P027.jpeg')


insert into Product_Table values('iBall Slide Nimble 4GF',
'Electronics','Tablets',
'Memory: 3 GB RAM | 16 GB ROM | Expandable Upto 64 GB',
'Display: 20.32 cm (8 inch) HD Display',
'Camera: 5 MP Primary Camera | 2 MP Front',
'Battery: 4300 mAh Lithium - Ion',
'Processor: ARM Coertex A53','8990',16,
'assets/P028.jpeg')


insert into Product_Table values('Alcatel 1T7',
'Electronics','Tablets',
'Memory: 1 GB RAM | 8 GB ROM | Expandable Upto 128 GB',
'Display: 17.78 cm (7 inch) Display',
'Camera: 5 MP Primary Camera | 2 MP Front',
'Battery: 2580 mAh Li-ion Polymer',
'Processor: MT8321A/D Quad Core Processor','3499',16,
'assets/P029.jpeg')


insert into Product_Table values('Alcatel 3T 8',
'Electronics','Tablets',
'Memory: 3 GB RAM | 32 GB ROM | Expandable Upto 128 GB',
'Display: 20.32 cm (8 inch) HD Display',
'Camera: 8 MP Primary Camera | 5 MP Front',
'Battery: 4080 mAh Li-ion Polymer',
'Processor: MT8765 Quad Core Processor','7999',16,
'assets/P030.jpeg')


insert into Product_Table values('Syska 10000 mAh Power Bank',
'Electronics','Powerbanks',
'Weight: 285 g ',
'Capacity: 10000 mAh',
'Lithium-ion Battery | Micro Connector',
'Power Source: USB connector',
'Charging Cable Included','649',16,
'assets/P031.jpeg')


insert into Product_Table values('Mi 10000 mAh Power Bank',
'Electronics','Powerbanks',
'Weight: 276 g ',
'Capacity: 10000 mAh',
'Lithium-ion Battery | Micro Connector',
'Power Source: USB connector',
'Charging Cable Included','649',16,
'assets/P032.jpeg')


insert into Product_Table values('Philips 11000 mAh Power Bank',
'Electronics','Powerbanks',
'Weight: 323 g',
'Capacity: 11000 mAh',
'Lithium-ion Battery | Micro Connector',
'Power Source: AC Adapter',
'Charging Cable Included','599',16,
'assets/P033.jpeg')


insert into Product_Table values('Philips 20000 mAh Power Bank',
'Electronics','Powerbanks',
'Weight: 421 g',
'Capacity: 20000 mAh',
'Lithium-ion Battery | Micro Connector',
'Power Source: AC Adapter',
'Charging Cable Included','1499',16,
'assets/P034.jpeg')


insert into Product_Table values('Rock 10000 mAh Power Bank',
'Electronics','Powerbanks',
'Weight: 270 g ',
'Capacity: 10000 mAh',
'Lithium-ion Battery | Micro Connector',
'Power Source: AC Adapter',
'Charging Cable Included','499',16,
'assets/P035.jpeg')


insert into Product_Table values('Ambrane 20000 mAh Power Bank',
'Electronics','Powerbanks',
'Weight: 470 g ',
'Capacity: 20000 mAh',
'Lithium-ion Battery | Micro Connector',
'Power Source: AC Adapter',
'Charging Cable Included','1199',16,
'assets/P036.jpeg')


insert into Product_Table values('Realme 10000 mAh Power Bank',
'Electronics','Powerbanks',
'Weight: 270 g ',
'Capacity: 10000 mAh',
'Lithium-ion Battery | Micro Connector',
'Power Source: AC Adapter',
'Charging Cable Included','1199',16,
'assets/P037.jpeg')


insert into Product_Table values('iBall 20000 mAh Power Bank',
'Electronics','Powerbanks',
'Weight: 339 g ',
'Capacity: 20000 mAh',
'Lithium-ion Battery | Micro Connector',
'Power Source: AC Adapter,USB',
'Charging Cable Included','999',16,
'assets/P038.jpeg')


insert into Product_Table values('Intex 12500 mAh Power Bank',
'Electronics','Powerbanks',
'Weight: 290 g',
'Capacity: 12500 mAh',
'Lithium-ion Battery | Micro Connector',
'Power Source: AC Adapter,USB',
'Charging Cable Included','799',16,
'assets/P039.jpeg')


insert into Product_Table values('Intex 20000 mAh Power Bank',
'Electronics','Powerbanks',
'Weight: 290 g',
'Capacity: 20000 mAh',
'Lithium-ion Battery | Micro Connector',
'Power Source: AC Adapter,USB',
'Charging Cable Included','1299',16,
'assets/P040.jpeg')


insert into Product_Table values('Mi LED Smart TV 4A PRO 80 cm',
'TVs & Appliances','Television',
'Supported Apps: Hotstar|Youtube',
'Operating System: Android (Google Assistant & Chromecast in-built)',
'Resolution: HD Ready 1366 x 768 Pixels',
'Sound Output: 20 W',
'Refresh Rate: 60 Hz','12499',16,
'assets/P041.jpeg')


insert into Product_Table values('iFFALCON by TCL AI Powered K31',
'TVs & Appliances','Television',
'Supported Apps: Netflix|Hotstar|Youtube',
'Operating System: Android (Google Assistant & Chromecast in-built)',
'Resolution: Ultra HD (4K) 3840 x 2160 Pixels',
'Sound Output: 20 W',
'Refresh Rate: 60 Hz','18499',16,
'assets/P042.jpeg')


insert into Product_Table values('Sony Bravia W800F 108cm',
'TVs & Appliances','Television',
'Supported Apps: Netflix|Prime Video|Hotstar|Youtube',
'Operating System: Android (Google Assistant & Chromecast in-built)',
'Resolution: Full HD 1920 x 1080 Pixels',
'Sound Output: 10 W',
'Refresh Rate: 50 Hz','46499',16,
'assets/P043.jpeg')


insert into Product_Table values('Sony Bravia X8500F',
'TVs & Appliances','Television',
'Supported Apps: Netflix|Prime Video|Hotstar|Youtube',
'Operating System: Android (Google Assistant & Chromecast in-built)',
'Resolution: Ultra HD (4K) 3840 x 2160 Pixels',
'Sound Output: 20 W',
'Refresh Rate: 100 Hz','92499',16,
'assets/P044.jpeg')


insert into Product_Table values('iFFALCON by TCL 138.71cm',
'TVs & Appliances','Television',
'Supported Apps: Netflix|Prime Video|Hotstar|Youtube',
'Operating System: Android (Google Assistant & Chromecast in-built)',
'Resolution: Ultra HD (4K) 3840 x 2160 Pixels',
'Sound Output: 16 W',
'Refresh Rate: 60 Hz','29999',16,
'assets/P045.jpeg')


insert into Product_Table values('Samsung Super 6 108cm',
'TVs & Appliances','Television',
'Supported Apps: Netflix|Prime Video|Hotstar|Youtube',
'Operating System: Android (Google Assistant & Chromecast in-built)',
'Resolution: Ultra HD (4K) 3840 x 2160 Pixels',
'Sound Output: 20 W',
'Refresh Rate: 60 Hz','36999',16,
'assets/P046.jpeg')


insert into Product_Table values('Samsung Q60RAK 108cm',
'TVs & Appliances','Television',
'Supported Apps: Netflix|Prime Video|Hotstar|Youtube',
'Operating System: Tizen',
'Resolution: Ultra HD (4K) 3840 x 2160 Pixels',
'Sound Output: 20 W',
'Refresh Rate: 100 Hz','66999',16,
'assets/P047.jpeg')


insert into Product_Table values('LG 108cm (43 inch) Ultra HD',
'TVs & Appliances','Television',
'Supported Apps: Netflix|Prime Video|Hotstar|Youtube',
'Operating System: WebOS',
'Resolution: Ultra HD (4K) 3840 x 2160 Pixels',
'Sound Output: 20 W',
'Refresh Rate: 50 Hz','36999',16,
'assets/P048.jpeg')


insert into Product_Table values('LG 123cm (49 inch) Ultra HD (4K)',
'TVs & Appliances','Television',
'Supported Apps: Netflix|Prime Video|Hotstar|Youtube',
'Operating System: WebOS',
'Resolution: Ultra HD (4K) 3840 x 2160 Pixels',
'Sound Output: 20 W',
'Refresh Rate: 50 Hz','74999',16,
'assets/P049.jpeg')


insert into Product_Table values('Thomson B9 Pro 80cm',
'TVs & Appliances','Television',
'Supported Apps: Netflix|Prime Video|Hotstar|Youtube',
'Operating System: Android Based',
'Resolution: HD Ready 1366 x 768 Pixels',
'Sound Output: 20 W',
'Refresh Rate: 50 Hz','9499',16,
'assets/P050.jpeg')


insert into Product_Table values('Samsung 6.5 kg Fully Automatic Top Load Silver',
'TVs & Appliances','Washing Machines',
'Fully Automatic Top Load Washing Machines are ergonomically friendly and provide great wash quality',
'700 rpm : Higher the spin speed, lower the drying time',
'Stainless Steel Best in class, Can withstand higher spin speeds for quick drying and durable',
'6.5 kg : Great for a family of 3',
'Lint Filter Supported','15350',16,
'assets/P051.jpeg')


insert into Product_Table values('Samsung 10 kg with Wobble Technology Fully Automatic Top Load Grey ',
'TVs & Appliances','Washing Machines',
'Fully Automatic Top Load Washing Machines are ergonomically friendly and provide great wash quality',
'700 rpm : Higher the spin speed, lower the drying time',
'Stainless Steel',
'10 kg : Great for Large families',
'Wobble Pulsator Wash','24999',16,
'assets/P052.jpeg')


insert into Product_Table values('MarQ by Flipkart 8.5 kg with Turbo Wash Fully Automatic Top Load Grey',
'TVs & Appliances','Washing Machines',
'Fully Automatic Top Load Washing Machines are ergonomically friendly and provide great wash quality',
'700 rpm : Higher the spin speed, lower the drying time',
'Stainless Steel',
'8.2 kg : Great for Large families',
'Number of wash programs - 8','15999',16,
'assets/P053.jpeg')


insert into Product_Table values('MarQ by Flipkart 6.5 kg with Twin Shower Technology Fully Automatic Top Load Grey',
'TVs & Appliances','Washing Machines',
'Fully Automatic Top Load Washing Machines are ergonomically friendly and provide great wash quality',
'700 rpm : Higher the spin speed, lower the drying time',
'Stainless Steel',
'6.5 kg : Great for Large families',
'Number of wash programs - 10','11499',16,
'assets/P054.jpeg')


insert into Product_Table values('LG 6.5 kg Inverter Fully Automatic Top Load Silver',
'TVs & Appliances','Washing Machines',
'Fully Automatic Top Load Washing Machines are ergonomically friendly and provide great wash quality',
'700 rpm : Higher the spin speed, lower the drying time',
'Stainless Steel',
'6.5 kg : Great for Large families',
'Number of wash programs - 3','16890',16,
'assets/P055.jpeg')


insert into Product_Table values('LG 8 kg 5 Star Rating Fully Automatic Top Load Silver ',
'TVs & Appliances','Washing Machines',
'Fully Automatic Top Load Washing Machines are ergonomically friendly and provide great wash quality',
'780 rpm : Higher the spin speed, lower the drying time',
'Stainless Steel',
'8 kg : Great for Large families',
'Number of wash programs - 4','16890',16,
'assets/P056.jpeg')


insert into Product_Table values('Haier 7.5 kg Fully Automatic Top Load Silver',
'TVs & Appliances','Washing Machines',
'Fully Automatic Top Load Washing Machines are ergonomically friendly and provide great wash quality',
'700 rpm : Higher the spin speed, lower the drying time',
'Stainless Steel',
'7.5 kg : Great for Large families',
'Number of wash programs - 4','16990',16,
'assets/P057.jpeg')


insert into Product_Table values('Haier 6.5 kg Fully Automatic Top Load Silver ',
'TVs & Appliances','Washing Machines',
'Fully Automatic Top Load Washing Machines are ergonomically friendly and provide great wash quality',
'700 rpm : Higher the spin speed, lower the drying time',
'Stainless Steel',
'6.5 kg : Great for Large families',
'Number of wash programs - 6','14100',16,
'assets/P058.jpeg')


insert into Product_Table values('Whirlpool 7.5 kg Fully Automatic Top Load with In-built Heater Grey',
'TVs & Appliances','Washing Machines',
'Fully Automatic Top Load Washing Machines are ergonomically friendly and provide great wash quality',
'700 rpm : Higher the spin speed, lower the drying time',
'Stainless Steel',
'7.5 kg : Great for family of 4',
'Number of wash programs - 12','23450',16,
'assets/P059.jpeg')


insert into Product_Table values('Whirlpool 6.5 kg Fully Automatic Top Load with In-built Heater Grey',
'TVs & Appliances','Washing Machines',
'Fully Automatic Top Load Washing Machines are ergonomically friendly and provide great wash quality',
'740 rpm : Higher the spin speed, lower the drying time',
'Stainless Steel',
'6.5 kg : Great for family of 3',
'Number of wash programs - 12','20700',16,
'assets/P060.jpeg')


insert into Product_Table values('Voltas 1.2 Ton 5 Star Split Inverter AC - White',
'TVs & Appliances','Air Conditioners',
'1.2 Ton',
'5 Star BEE Rating 2019 : For energy savings upto 25% (compared to Non-Inverter 1 Star)',
'Auto Restart: No need to manually reset the settings post power-cut',
'Copper : Energy efficient, best in class cooling with easy maintenance.',
'Sleep Mode: Auto-adjusts the temperature to ensure comfort during your sleep','30999',16,
'assets/P061.jpeg')


insert into Product_Table values('MarQ by Flipkart 1 Ton 3 Star Split Inverter AC - White',
'TVs & Appliances','Air Conditioners',
'1 Ton',
'3 Star BEE Rating 2019 : For energy savings upto 15% (compared to Non-Inverter 1 Star)',
'Auto Restart: No need to manually reset the settings post power-cut',
'Copper : Energy efficient, best in class cooling with easy maintenance.',
'Sleep Mode: Auto-adjusts the temperature to ensure comfort during your sleep','21999',16,
'assets/P062.jpeg')


insert into Product_Table values('Midea 1.5 Ton 3 Star Split AC - White',
'TVs & Appliances','Air Conditioners',
'1.5 Ton : Great for medium sized rooms (110-150 sq ft)',
'3 Star BEE Rating 2019 : For energy savings upto 15% (compared to Non-Inverter 1 Star)',
'Auto Restart: No need to manually reset the settings post power-cut',
'Copper : Energy efficient, best in class cooling with easy maintenance.',
'Sleep Mode: Auto-adjusts the temperature to ensure comfort during your sleep','24999',16,
'assets/P063.jpeg')

insert into Product_Table values('Panasonic 1.5 Ton 3 Star Split Inverter AC - White ',
'TVs & Appliances','Air Conditioners',
'1.5 Ton : Great for medium sized rooms (110-150 sq ft)',
'3 Star BEE Rating 2019 : For energy savings upto 15% (compared to Non-Inverter 1 Star)',
'Auto Restart: No need to manually reset the settings post power-cut',
'Copper : Energy efficient, best in class cooling with easy maintenance.',
'Sleep Mode: Auto-adjusts the temperature to ensure comfort during your sleep','34999',16,
'assets/P064.jpeg')


insert into Product_Table values('Livpure 1.5 Ton 3 Star Split Inverter AC with Wi-fi Connect - White',
'TVs & Appliances','Air Conditioners',
'1.5 Ton : Great for medium sized rooms (110-150 sq ft)',
'3 Star BEE Rating 2019 : For energy savings upto 15% (compared to Non-Inverter 1 Star)',
'Auto Restart: No need to manually reset the settings post power-cut',
'Copper : Energy efficient, best in class cooling with easy maintenance.',
'Sleep Mode: Auto-adjusts the temperature to ensure comfort during your sleep','30999',16,
'assets/P065.jpeg')


insert into Product_Table values('Carrier 1.2 Ton 5 Star Split Inverter AC - White',
'TVs & Appliances','Air Conditioners',
'1.2 Ton : Great for medium sized rooms (110-150 sq ft)',
'5 Star BEE Rating 2019 : For energy savings upto 25% (compared to Non-Inverter 1 Star)',
'Auto Restart: No need to manually reset the settings post power-cut',
'Copper : Energy efficient, best in class cooling with easy maintenance.',
'Sleep Mode: Auto-adjusts the temperature to ensure comfort during your sleep','32999',16,
'assets/P066.jpeg')


insert into Product_Table values('Sansui 2 Ton 3 Star Split Triple Inverter AC - White',
'TVs & Appliances','Air Conditioners',
'2 Ton : Great for medium sized rooms (110-150 sq ft)',
'3 Star BEE Rating 2019 : For energy savings upto 15% (compared to Non-Inverter 1 Star)',
'Auto Restart: No need to manually reset the settings post power-cut',
'Copper : Energy efficient, best in class cooling with easy maintenance.',
'Sleep Mode: Auto-adjusts the temperature to ensure comfort during your sleep','34999',16,
'assets/P067.jpeg')


insert into Product_Table values('LG 1.5 Ton 5 Star Split Inverter AC - White',
'TVs & Appliances','Air Conditioners',
'1.5 Ton : Great for medium sized rooms (110-150 sq ft)',
'5 Star BEE Rating 2019 : For energy savings upto 25% (compared to Non-Inverter 1 Star)',
'Auto Restart: No need to manually reset the settings post power-cut',
'Copper : Energy efficient, best in class cooling with easy maintenance.',
'Sleep Mode: Auto-adjusts the temperature to ensure comfort during your sleep','40999',16,
'assets/P068.jpeg')


insert into Product_Table values('Godrej 1 Ton 3 Star Split AC - White',
'TVs & Appliances','Air Conditioners',
'1 Ton : Great for small sized rooms (upto 90 sq ft)',
'5 Star BEE Rating 2019 : For energy savings upto 25% (compared to Non-Inverter 1 Star)',
'Auto Restart: No need to manually reset the settings post power-cut',
'Copper : Energy efficient, best in class cooling with easy maintenance.',
'Sleep Mode: Auto-adjusts the temperature to ensure comfort during your sleep','25400',16,
'assets/P069.jpeg')


insert into Product_Table values('Whirlpool 0.8 Ton 3 Star Split Inverter AC - White',
'TVs & Appliances','Air Conditioners',
'0.8 Ton : Great for small sized rooms (upto 90 sq ft)',
'3 Star BEE Rating 2018 : For energy savings upto 15% (compared to Non-Inverter 1 Star)',
'Auto Restart: No need to manually reset the settings post power-cut',
'Copper : Energy efficient, best in class cooling with easy maintenance.',
'Sleep Mode: Auto-adjusts the temperature to ensure comfort during your sleep','23990',16,
'assets/P070.jpeg')


insert into Product_Table values('Samsung 192 L Direct Cool Single Door 4 Star Refrigerator with Base Drawer',
'TVs & Appliances','Refrigerators ',
'192 L : Good for couples and small families',
'Inverter Compressor',
'4 Star : For Energy savings up to 45%',
'Direct Cool : Economical, consumes less electricity, requires manual defrosting',
'Base Stand with Drawer : For storing items that dont need cooling (Onion Potato etc)','16990',16,
'assets/P071.jpeg')


insert into Product_Table values('Samsung 275 L Frost Free Double Door 4 Star Convertible Refrigerator ',
'TVs & Appliances','Refrigerators ',
'275 L : Good for families of 3-5 members',
'Digital Inverter Compressor',
'4 Star : For Energy savings up to 45%',
'Frost Free : Auto fridge defrost to stop ice-build up',
'Convertible: Offers you more space for all the food you need to store','30180',16,
'assets/P072.jpeg')


insert into Product_Table values('Panasonic 305 L Frost Free Double Door 3 Star Refrigerator',
'TVs & Appliances','Refrigerators ',
'305 L : Good for families of 3-5 members',
'Inverter Compressor',
'3 Star : For Energy savings up to 35%',
'Frost Free : Auto fridge defrost to stop ice-build up',
'Convertible: Offers you more space for all the food you need to store','26990',16,
'assets/P073.jpeg')


insert into Product_Table values('LG 215 L Direct Cool Single Door 5 Star Refrigerator ',
'TVs & Appliances','Refrigerators ',
'215 L : Good for couples and small families',
'Smart Inverter Compresso',
'5 Star : For Energy savings up to 55%',
'Direct Cool : Economical, consumes less electricity, requires manual defrosting',
'Convertible: Offers you more space for all the food you need to store','17990',16,
'assets/P074.jpeg')

insert into Product_Table values('LG 420 L Frost Free Double Door 4 Star Refrigerator',
'TVs & Appliances','Refrigerators ',
'420 L : Good for large families',
'Smart Inverter Compressor : Consumes lower electricity in comparison to a Normal compressor',
'4 Star : For Energy savings up to 45%',
'Frost Free : Auto fridge defrost to stop ice-build up',
'Convertible: Offers you more space for all the food you need to store','46990',16,
'assets/P075.jpeg')


insert into Product_Table values('Haier 195 L Direct Cool Single Door 4 Star Refrigerator with Base Drawer',
'TVs & Appliances','Refrigerators ',
'195 L : Good for couples and small families',
'Reciprocatory Compressor : Standard type of Compressor with Easy Maintenance',
'4 Star : For Energy savings up to 45%',
'Direct Cool : Economical, consumes less electricity, requires manual defrosting',
'Base Stand with Drawer : For storing items that donot need cooling (Onion Potato etc)','15490',16,
'assets/P076.jpeg')


insert into Product_Table values('Haier 347 L Frost Free Double Door 3 Star Refrigerator',
'TVs & Appliances','Refrigerators ',
'347 L : Good for families of 3-5 members',
'Reciprocatory Compressor : Standard type of Compressor with Easy Maintenance',
'3 Star : For Energy savings up to 35%',
'Frost Free : Auto fridge defrost to stop ice-build up',
'Base Stand with Drawer : For storing items that donot need cooling (Onion Potato etc)','28990',16,
'assets/P077.jpeg')


insert into Product_Table values('Whirlpool 190 L Direct Cool Single Door 3 Star Refrigerator with Base Drawer',
'TVs & Appliances','Refrigerators ',
'190 L : Good for couples and small families',
'Rotary Compressor',
'3 Star : For Energy savings up to 35%',
'Direct Cool : Economical, consumes less electricity, requires manual defrosting',
'Base Stand with Drawer : For storing items that dont need cooling (Onion, Potato etc)','12490',16,
'assets/P078.jpeg')


insert into Product_Table values('Whirlpool 245 L Frost Free Double Door 2 Star Refrigerator',
'TVs & Appliances','Refrigerators ',
'245 L : Good for families of 3-5 members',
'Reciprocatory Compressor',
'2 Star : For Energy savings up to 20%',
'Frost Free : Auto fridge defrost to stop ice-build up',
'Base Stand with Drawer : For storing items that dont need cooling (Onion, Potato etc)','19720',16,
'assets/P079.jpeg')


insert into Product_Table values('Godrej 236 L Frost Free Double Door 2 Star Refrigerator',
'TVs & Appliances','Refrigerators ',
'236 L : Good for families of 3-5 members',
'Reciprocatory Compressor',
'2 Star : For Energy savings up to 20%',
'Frost Free : Auto fridge defrost to stop ice-build up',
'Base Stand with Drawer : For storing items that dont need cooling (Onion, Potato etc)','18387',16,
'assets/P080.jpeg')


insert into Product_Table values('Glun LCD Rewritable Erasable Paperless Memo Writing Tablet  Drawing Board with Pen ',
'Baby & Kids','Toys',
'Plastic Material',
'AA Battery',
'Non Rechargeable',
'Width x Height: 146 mm x 226 mm',
'Age: 3+ Years','299',16,
'assets/P081.jpeg')


insert into Product_Table values('Miss & Chief Magnetic alphabets for kids',
'Baby & Kids','Toys',
'Plastic Material',
'No batteries Battery',
'Non Rechargeable',
'Width x Height: 20 mm x 170 mm',
'Age: 3+ Years','499',16,
'assets/P082.jpeg')


insert into Product_Table values('Zurie Toy Collection Off Road Monster Racing Car, Remote Control , 1:20 Scale, Black',
'Baby & Kids','Toys',
'Material: Plastic',
'Battery Operated, 0 Battteries',
'Rechargeable Batteries',
'Width x Height: 22 cm x 14 cm',
'Age: 3+ Years','899',16,
'assets/P083.jpeg')


insert into Product_Table values('AR Enterprises RC Jackman Ferrari Style Racing Rechargeable Car With Radio Control Steering  (Red)',
'Baby & Kids','Toys',
'Material: Plastic',
'Battery Operated, 2 Battteries',
'Rechargeable Batteries',
'Width x Height: 6 inch x 3 inch',
'Age: 4+ Years','589',16,
'assets/P084.jpeg')


insert into Product_Table values('Hot Wheels Crashing Rig ',
'Baby & Kids','Toys',
'Material: Plastic',
'Non-battery Operated',
'Non-rechargeable Batteries',
'Width x Height: 6 inch x 3 inch',
'Age: 4+ Years','589',16,
'assets/P085.jpeg')


insert into Product_Table values('CENTY TMP 207 AMBULANCE ',
'Baby & Kids','Toys',
'Material: Plastic',
'Non-battery Operated',
'Non-rechargeable Batteries',
'Width x Height: 6 inch x 3 inch',
'Age: 4+ Years','299',16,
'assets/P086.jpeg')


insert into Product_Table values('Hot Wheels 3 car gift pack ',
'Baby & Kids','Toys',
'Material: Plastic',
'Non-battery Operated',
'Non-rechargeable Batteries',
'Packs Include Three Hot Wheels Vehicles With Genuine Die-Cast Parts.',
'Age: 3+ Years','204',16,
'assets/P087.jpeg')


insert into Product_Table values('Miss & Chief Colorful Graffiti Foldable Scooty  ',
'Baby & Kids','Toys',
'Material: Steel',
'Non-battery Operated',
'Non-rechargeable Batteries',
'Width x Height: 22 cm x 83 cm',
'Age: 3+ Years','1749',16,
'assets/P088.jpeg')

insert into Product_Table values('Miss & Chief Play tent house for kids in school theme',
'Baby & Kids','Toys',
'Material: Fabric',
'Non-battery Operated',
'Non-rechargeable Batteries',
'Width x Height: 723.9 mm x 105.41 cm',
'Age: 3+ Years','699',16,
'assets/P089.jpeg')

insert into Product_Table values('Marvel Spider-Man Flying Disc for Kids',
'Baby & Kids','Toys',
'Material: Plastic',
'Non-battery Operated',
'Non-rechargeable Batteries',
'Width x Height: 23 cm x 23 cm',
'Age: 4+ Years','699',16,
'assets/P090.jpeg')


insert into Product_Table values('Marvel Spider-Man Flying Disc for Kids',
'Baby & Kids','School Supplies',
'School Bag',
'Polyester',
'For Boys',
'Number of Compartments: 2',
'Class: High School','859',16,
'assets/P091.jpeg')

insert into Product_Table values('Spiderman Web Slinging 46cm Secondary (Secondary 3rd Std Plus) School Bag',
'Baby & Kids','School Supplies',
'School Bag',
'Polyester',
'For Boys',
'Number of Compartments: 2',
'Class: High School','839',16,
'assets/P092.jpeg')


insert into Product_Table values('Pilot V7 (Pack of 3) Blue Roller Ball Pen ',
'Baby & Kids','School Supplies',
'Pens & Pencils',
'Body Color: Blue',
'Made of Plastic',
'Ink Color: Blue',
'Pack of 3','101',16,
'assets/P093.jpeg')

insert into Product_Table values('Cello Technotip Ball Pen  (Pack of 20)',
'Baby & Kids','School Supplies',
'Pens & Pencils',
'Body Color: Blue',
'Made of Plastic',
'Ink Color: Blue',
'Pack of 3','140',16,
'assets/P094.jpeg')

insert into Product_Table values('Camel Wax Crayons Extra Long ',
'Baby & Kids','School Supplies',
'Art Supplies',
'Crayon Type: Wax',
'Crayon Shape: Round',
'Number of Crayons: 24',
'Multicolor','140',16,
'assets/P095.jpeg')


insert into Product_Table values('Faber-Castell 50 Oil Pastels',
'Baby & Kids','School Supplies',
'Art Supplies',
'Crayon Type: Oil Pastel',
'Crayon Shape: Round',
'Number of Crayons: 50',
'Color: Assorted','144',16,
'assets/P096.jpeg')


insert into Product_Table values('Disney GENUINE LICENSED PRINCESS LUNCH BOX',
'Baby & Kids','School Supplies',
'Lunch Boxes',
'Lunch Box Material: Plastic',
'Ideal Usage: School',
'Capacity: 750',
'Number of Containers: 1','149',16,
'assets/P097.jpeg')


insert into Product_Table values('Disney GENUINE LICENSED CINDERELLA INSIDE STAINLESS STEEL LUNCH BOX ',
'Baby & Kids','School Supplies',
'Lunch Boxes',
'Lunch Box Material: Plastic',
'Ideal Usage: School',
'Capacity: 980',
'Number of Containers: 1','399',16,
'assets/P098.jpeg')


insert into Product_Table values('Cello Smarty Trendy Mechanical Pencil',
'Baby & Kids','School Supplies',
'Character: None',
'Grade: 2B',
'Shape: Round',
'Number of Pencils: 15',
'Eraser Attached','89',16,
'assets/P099.jpeg')


insert into Product_Table values('DOMS PCS-0001 Non-Toxic Eraser',
'Baby & Kids','School Supplies',
'School Accessories',
'Pack of 50',
'Eraser Size: 3',
'Non-Toxic',
'Color: Multicolor','145',16,
'assets/P100.jpeg')


insert into Product_Table values('Neska Moda 0 To 12 Month Set Of 2 Baby Booties ',
'Baby & Kids','Kids Footwear',
'Material: Cotton',
'For Baby Boys & Baby Girls',
'Size in Length: 12 cm',
'Color: Black, Pink',
'Sole Type: Cotton','249',16,
'assets/P101.jpeg')


insert into Product_Table values('LMN Child Care Booties ',
'Baby & Kids','Kids Footwear',
'Material: Cotton',
'For Baby Boys & Baby Girls',
'Size in Length: 6 cm',
'Color: Red, White',
'Sole Type: Cotton','199',16,
'assets/P102.jpeg')

insert into Product_Table values('LMN Child Care Booties ',
'Baby & Kids','Kids Footwear',
'Material: Cotton',
'For Baby Boys & Baby Girls',
'Size in Length: 6 cm',
'Color: Red, White',
'Sole Type: Cotton','199',16,
'assets/P103.jpeg')

insert into Product_Table values('Neska Moda Rabbit 6 To 18 Month Baby Booties',
'Baby & Kids','Kids Footwear',
'Material: Fabric, Cotton',
'For Baby Boys & Baby Girls',
'Size in Length: 12 cm',
'Color: White, Blue',
'Sole Type: Cotton','169',16,
'assets/P104.jpeg')


insert into Product_Table values('Neska Moda Rabbit 6 To 18 Month Baby Booties',
'Baby & Kids','Kids Footwear',
'Material: Synthetic, Leather',
'For Boys',
'Size in Length: 12 cm',
'Color: Black',
'Sole Type: Phylon','889',16,
'assets/P105.jpeg')


insert into Product_Table values('Boys Slip on Sneakers ',
'Baby & Kids','Kids Footwear',
'Material: Canvas',
'For Boys',
'Size in Length: 12 cm',
'Color: Black',
'Sole Type: PVC','299',16,
'assets/P106.jpeg')


insert into Product_Table values('Girls Slip on Ballerinas',
'Baby & Kids','Kids Footwear',
'Material: PU',
'For Boys',
'Size in Length: 12 cm',
'Color: Black',
'Sole Type: PVC','419',16,
'assets/P107.jpeg')


insert into Product_Table values('Boys Lace Sneakers',
'Baby & Kids','Kids Footwear',
'Material: Canvas',
'For Boys',
'Size in Length: 13 cm',
'Color: Black',
'Sole Type: Airmix','419',16,
'assets/P108.jpeg')

insert into Product_Table values('Girls Velcro Strappy Sandals',
'Baby & Kids','Kids Footwear',
'Material: Rubber',
'For Boys',
'Size in Length: 6C',
'Color: Black',
'Sole Type: PU','389',16,
'assets/P109.jpeg')

insert into Product_Table values('Girls Velcro Ballerinas ',
'Baby & Kids','Kids Footwear',
'Material: Synthetic leather',
'For Boys',
'Size in Length: 10C',
'Color: Black',
'Sole Type: PVC','419',16,
'assets/P110.jpeg')


insert into Product_Table values('Solid Kids Muffler  (Red)',
'Baby & Kids','Winterwear',
'Brand:ET BAZAR',
'Style Code:ET-MUF-DLT',
'Size:5 - 6 Years',
'Brand Color:ET-RED',
'Ideal For:Baby Boys & Baby Girls','473',16,
'assets/P111.jpeg')

insert into Product_Table values('Full Sleeve Solid Boys & Girls Sweatshirt',
'Baby & Kids','Winterwear',
'Color:Black',
'Fabric:Pure Cotton',
'Pattern:Solid',
'Sleeve:Full Sleeve',
'Style Code:ABSTCRGP553543','845',16,
'assets/P112.jpeg')

insert into Product_Table values('Full Sleeve Solid Boys Sweatshirt',
'Baby & Kids','Winterwear',
'Color:Black',
'Fabric:Pure Cotton',
'Pattern:Solid',
'Sleeve:Full Sleeve',
'Style Code: ABSTCRGP553543','639',16,
'assets/P113.jpeg')


insert into Product_Table values('Full Sleeve Solid Sweatshirt',
'Baby & Kids','Winterwear',
'Color:Green',
'Fabric:Pure Cotton',
'Pattern:Solid',
'Neck:Round Neck',
'Sleeve:Full Sleeve','539',16,
'assets/P114.jpeg')

insert into Product_Table values('Pyjama For Boys & Girls ',
'Baby & Kids','Winterwear',
'Number of Thermals:1',
'Brand:NEVA',
'Style Code:OVT06GKIDMILANGEGREY',
'Brand Color:Milange Grey',
'Size:0 - 6 Months','539',16,
'assets/P115.jpeg')


insert into Product_Table values('Top - Pyjama Set For Boys & Girls',
'Baby & Kids','Winterwear',
'Number of Thermals:6',
'Brand:Manzon',
'Style Code:MN456',
'Brand Color:Multicolor',
'Size:0 - 6 Months','539',16,
'assets/P116.jpeg')


insert into Product_Table values('Top - Pyjama Set For Boys & Girls',
'Baby & Kids','Winterwear',
'Number of Pairs:4',
'Brand:Atabz',
'Style Code:4 Pairs Mittens for Kids',
'Brand Color:multicolor',
'Size:0 - 6 Months','229',16,
'assets/P117.jpeg')


insert into Product_Table values('Top For Boys & Girls ',
'Baby & Kids','Winterwear',
'Brand:NEVA',
'Style Code:OMDQ1GKIDMILANGEGREY',
'Brand Color:Milange Grey',
'Size:0 - 6 Months',
'Ideal For:Boys & Girls','499',16,
'assets/P118.jpeg')


insert into Product_Table values('Full Sleeve Printed Boys Sweatshirt',
'Baby & Kids','Winterwear',
'Fabric:Pure Cotton',
'Pattern:Printed',
'Neck:Crew Neck',
'Sleeve:Full Sleeve',
'Style Code:PB581181L','799',16,
'assets/P119.jpeg')

insert into Product_Table values('Full Sleeve Printed Boys Sweatshirt',
'Baby & Kids','Winterwear',
'Fabric:Cotton Blend',
'Pattern:Solid',
'Neck:Hooded Neck',
'Sleeve:Full Sleeve',
'Style Code:AW19_H_B_PLN_BL','549',16,
'assets/P120.jpeg')


insert into Product_Table values('Alma 175 Stevia Sugar Free Tablets (Made & Packed In Spain) Natural Sweetener  (9 g)',
'Grocery','Sugar and Sweetners',
'Brand:Alma',
'Model Name:175 Stevia Sugar Free Tablets (Made & Packed In Spain) Natural',
'Container Type:Plastic Bottle',
'Ingredients:Glycosides, Sweetener',
'Common Name:Stevia Tablets, Sugarfree tablets & natural sweetener','275',16,
'assets/P121.jpeg')


insert into Product_Table values('Origo Fresh Round Jaggery  (500 g)',
'Grocery','Sugar and Sweetners',
'Brand:Origo Fresh',
'Model Name:Round',
'Container Type:Pouch',
'Form:Block',
'Type:Sugarcane Jaggery','41',16,
'assets/P122.jpeg')

insert into Product_Table values('MilTop Natural Jaggery  (500 g)',
'Grocery','Sugar and Sweetners',
'Brand:MilTop',
'Model Name:Natural',
'Container Type:Plastic Bottle',
'Form:Powder',
'Type:Sugarcane Jaggery','81',16,
'assets/P123.jpeg')

insert into Product_Table values('Parrys Pure Refined Sugar  (1 kg)',
'Grocery','Sugar and Sweetners',
'Brand:Parrys',
'Model Name:Pure Refined',
'Form Factor:Crystal',
'Type:White Sugar',
'Container Type:Pouch','74',16,
'assets/P124.jpeg')


insert into Product_Table values('Dhampur Green Jaggery ( Gur) 220gm ( Pack of 4 ) Jaggery  (220 g, Pack of 4)',
'Grocery','Sugar and Sweetners',
'Brand:Dhampur',
'Model Name:Green Jaggery ( Gur) 220gm ( Pack of 4 )',
'Container Type:Pouch',
'Form:Block',
'Type:Sugarcane Jaggery','99',16,
'assets/P125.jpeg')

insert into Product_Table values('Canderel Granular Low Calorie Sweetener 40g Sweetener  (40 g)',
'Grocery','Sugar and Sweetners',
'Brand:Canderel',
'Model Name:Granular Low Calorie Sweetener 40g',
'Used For:Cooking, Baking, Drinking',
'Form:Powder',
'Container Type Glass Bottle','339',16,
'assets/P126.jpeg')


insert into Product_Table values('Splenda No Calorie Sweetener 100 Pkt Sweetener  (100 Sachet)',
'Grocery','Sugar and Sweetners',
'Brand:Splenda',
'Model Name:No Calorie Sweetener 100 Pkt',
'Used For:Sweetner',
'Form:Powder',
'Container Type:Sachet','440',16,
'assets/P127.jpeg')


insert into Product_Table values('Alma 1300 Sugar free tablets (Made & Packed In Spain) zero calorie Sweetener',
'Grocery','Sugar and Sweetners',
'For Fitness Freaks',
'Can use for milk&shake',
'No additives',
'Maintains Sugar Level',
'1stAutomatic dispenser','889',16,
'assets/P128.jpeg')


insert into Product_Table values('Veg E Wagon Custard Powder Vanilla Flavoured Sugar  (1 kg)',
'Grocery','Sugar and Sweetners',
'Brand:Veg E Wagon',
'Model Name:Custard Powder Vanilla Flavoured',
'Quantity:1 kg',
'Form Factor:Powder',
'Type:Powder Sugar','249',16,
'assets/P129.jpeg')


insert into Product_Table values('Cape Fresh Panankarkandu Palmyra Tree Palm Palm Candy',
'Grocery','Sugar and Sweetners',
'Brand:Cape Fresh',
'Model Name:( Karupatti ) Palmyra tree Palm',
'Quantity:1500 g',
'Container Type:Pouch',
'Type:Palm Jaggery','389',16,
'assets/P130.jpeg')


insert into Product_Table values('Tata Sampann Unpolished White Urad Dal (Whole)  (1 kg)',
'Grocery','Dals and Pulses',
'Brand:Tata Sampann',
'Type:Urad Dal',
'Quantity:1 kg',
'Form:Whole',
'Common Name:Urad Dal','65',16,
'assets/P131.jpeg')


insert into Product_Table values('Chana Brown  (500 g)',
'Grocery','Dals and Pulses',
'Brand:Un Branded',
'Type:Chana',
'Quantity:500 g',
'Form:NA',
'Common Name:Chana','44',16,
'assets/P132.jpeg')


insert into Product_Table values('Masoor Dal Red (Split)  (500 g)',
'Grocery','Dals and Pulses',
'Brand:Un Branded',
'Type:Masoor Dal',
'Quantity:500 g',
'Form:Split',
'Common Name:Dal','47',16,
'assets/P133.jpeg')


insert into Product_Table values('Flipkart Supermart Select Yellow Fried Gram (Whole)  (200 g)',
'Grocery','Dals and Pulses',
'Brand:Flipkart Supermart Select',
'Type:Fried Gram',
'Quantity:200 g',
'Form:Whole',
'Common Name:Chana','32',16,
'assets/P134.jpeg')


insert into Product_Table values('Tata Sampann Unpolished Yellow Moong Dal (Split)  (500 g)',
'Grocery','Dals and Pulses',
'Brand:Tata Sampann',
'Type:Moong Dal',
'Quantity:500 g',
'Form:Split',
'Common Name:Moong Dal','134',16,
'assets/P135.jpeg')


insert into Product_Table values('Flipkart Supermart Select Soya Bean  (500 g)',
'Grocery','Dals and Pulses',
'Brand:Flipkart',
'Type:Soya Bean',
'Quantity:500 g',
'Form:Whole',
'Common Name:Soya Beans','43',16,
'assets/P136.jpeg')


insert into Product_Table values('Flipkart Supermart Select Green Peas  (500 g)',
'Grocery','Dals and Pulses',
'Brand:Flipkart',
'Type:Green Peas',
'Quantity:500 g',
'Form:Whole',
'Common Name:Green Peas','65',16,
'assets/P137.jpeg')


insert into Product_Table values('Flipkart Supermart Select W320 Whole Cashews  (500 g)',
'Grocery','Dals and Pulses',
'Brand:Flipkart',
'Type:Cashews',
'Quantity:500 g',
'Form:Whole',
'Common Name:Cashews','510',16,
'assets/P138.jpeg')


insert into Product_Table values('Safe Harvest Rajma Chithra (Whole)  (500 g)',
'Grocery','Dals and Pulses',
'Brand:Safe Harvest',
'Type:Rajma Chithra',
'Quantity:500 g',
'Form:Whole',
'Common Name:Rajma','93',16,
'assets/P139.jpeg')

insert into Product_Table values('Rajma White  (1 kg)',
'Grocery','Dals and Pulses',
'Brand:Unbranded',
'Type:Rajma White',
'Quantity: 1kg',
'Form:Whole',
'Common Name:Rajma','121',16,
'assets/P140.jpeg')

insert into Product_Table values('Figaro Olive Oil Tin  (Vegetable Chopping Board Free)  (5 L)',
'Grocery','Edible Oils',
'Brand:Figaro',
'Model Name:Pomace Olive Oil JAR',
'Type:Olive Oil',
'Quantity:5 L',
'Processing Type:Refined','3215',16,
'assets/P141.jpeg')


insert into Product_Table values('KLF Coconad Coconut Oil Pouch  (1 L)',
'Grocery','Edible Oils',
'Brand:KLF',
'Model Name:Coconad Coconut Oil',
'Type:Coconut Oil',
'Quantity:1 L',
'Processing Type:Refined','255',16,
'assets/P142.jpeg')

insert into Product_Table values('Emami Healthy & Tasty Kachchi Ghani Mustard Oil Plastic Bottle  (500 ml)',
'Grocery','Edible Oils',
'Brand:Emami',
'Model Name:Refined',
'Type:Mustard Oil',
'Quantity:500ml',
'Used For:Cooking','55',16,
'assets/P143.jpeg')

insert into Product_Table values('Fortune Sunlite Refined Sunflower Oil Plastic Bottle  (1 L)',
'Grocery','Edible Oils',
'Brand:Fortune',
'Model Name:Refined',
'Type:Sunflower Oil',
'Quantity:1 L',
'Used For:Cooking','95',16,
'assets/P144.jpeg')

insert into Product_Table values('Palmpure Palm Oil Pouch  (1 L)',
'Grocery','Edible Oils',
'Brand:Palmure',
'Model Name:Refined',
'Type:Palm Oil',
'Quantity:1 L',
'Used For:Cooking','75',16,
'assets/P145.jpeg')

insert into Product_Table values('Freedom Physically Refined Rice Bran Oil Pouch  (1 L)',
'Grocery','Edible Oils',
'Brand:Freedom',
'Model Name:Refined',
'Type:Rice Bran Oil',
'Quantity:1 L',
'Used For:Cooking','97',16,
'assets/P146.jpeg')


insert into Product_Table values('Vedhas Gold Filtered Groundnut Oil Pouch  (1 L)',
'Grocery','Edible Oils',
'Brand:Vedhas',
'Model Name:Refined',
'Type:Groundnut Oil',
'Quantity:1 L',
'Used For:Cooking','124',16,
'assets/P147.jpeg')

insert into Product_Table values('Idhayam Sesame Oil Pouch  (1 L)',
'Grocery','Edible Oils',
'Brand:Idhayam',
'Model Name:Refined',
'Type:Sesame Oil',
'Quantity:1 L',
'Used For:Cooking','324',16,
'assets/P148.jpeg')


insert into Product_Table values('Saffola Tasty Blended Oil Pouch  (1 L)',
'Grocery','Edible Oils',
'Brand:Saffola',
'Model Name:Refined',
'Type:Blended Oil',
'Quantity:1 L',
'Used For:Cooking','110',16,
'assets/P149.jpeg')


insert into Product_Table values('Patanjali Rice Bran Oil Plastic Bottle  (1 L)',
'Grocery','Edible Oils',
'Brand:Patanjali',
'Model Name:Refined',
'Type:Rice Bran Oil',
'Quantity:1 L',
'Used For:Cooking','115',16,
'assets/P150.jpeg')


insert into Product_Table values('Flipkart Supermart Select Californian Almonds  (100 g)',
'Grocery','Dry Fruits,Nuts & Seeds',
'Brand:Flipkart Supermart Select',
'Quantity:100 g',
'Type:Almonds',
'Variant:Plain',
'Container Type:Pouch','507',16,
'assets/P151.jpeg')


insert into Product_Table values('Origo Fresh Regular Californian Almonds  (500 g)',
'Grocery','Dry Fruits,Nuts & Seeds',
'Brand:Origo',
'Quantity:500 g',
'Type:Almonds',
'Variant:Plain',
'Container Type:Pouch','449',16,
'assets/P152.jpeg')

insert into Product_Table values('Origo Fresh Split Cashews  (100 g)',
'Grocery','Dry Fruits,Nuts & Seeds',
'Brand:Origo',
'Quantity:100 g',
'Type:Cashews',
'Variant:Plain',
'Container Type:Pouch','191',16,
'assets/P153.jpeg')

insert into Product_Table values('Happilo 100% Natural California Almonds  (200 g)',
'Grocery','Dry Fruits,Nuts & Seeds',
'Brand:Happilo',
'Quantity:200 g',
'Type:Almonds',
'Variant:Plain',
'Container Type:Pouch','385',16,
'assets/P154.jpeg')


insert into Product_Table values('Flipkart Supermart Select Indian Raisins  (500 g)',
'Grocery','Dry Fruits,Nuts & Seeds',
'Brand:Flipkart',
'Quantity:500 g',
'Type:Raisins',
'Variant:Plain',
'Container Type:Pouch','214',16,
'assets/P155.jpeg')


insert into Product_Table values('Rostaa Apricots  (200 g)',
'Grocery','Dry Fruits,Nuts & Seeds',
'Brand:Rostaa',
'Quantity:200 g',
'Type:Apricots',
'Variant:Plain',
'Container Type:Pouch','182',16,
'assets/P156.jpeg')

insert into Product_Table values('Lion Deseeded Dates  (500 g)',
'Grocery','Dry Fruits,Nuts & Seeds',
'Brand:Lion',
'Quantity:500 g',
'Type:Dates',
'Variant:Plain',
'Container Type:Pouch','107',16,
'assets/P157.jpeg')

insert into Product_Table values('Ziofit Afghani Dried Figs  (Combo Pack 1 + 1 Free, 200 g each)  (200 g)',
'Grocery','Dry Fruits,Nuts & Seeds',
'Brand:Ziofit',
'Quantity:200 g',
'Type:Dried Figs',
'Variant:Plain',
'Container Type:Pouch','525',16,
'assets/P158.jpeg')


insert into Product_Table values('Happilo Premium International Healthy Nutmix  (200 g)',
'Grocery','Dry Fruits,Nuts & Seeds',
'Brand:Happolo',
'Quantity:200 g',
'Type:Nutmix',
'Variant:Plain',
'Container Type:Pouch','525',16,
'assets/P159.jpeg')


insert into Product_Table values('Lion Arabian Dates  (Combo Pack 1 + 1 Free, 500 g each)  (500 g)',
'Grocery','Dry Fruits,Nuts & Seeds',
'Brand:Lion ',
'Quantity:500 g',
'Type:Arabian Dates',
'Variant:Plain',
'Container Type:Pouch','177',16,
'assets/P160.jpeg')
select * from Product_Table

select * from OrderTable

select  p.Product_Id,o.ord_id,o.email from Product_Table  p  join OrderTable o  on 
p.Product_Id=o.prod_id where ord_id=144