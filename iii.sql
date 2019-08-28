/* 0. 庫名: iii */
drop database if exists `iii`;
create database `iii` default character set utf8;
use iii;

/* 1. 客戶資料表 */
drop table if exists `Customers`;
create table `Customers`(
  `CustomerID` int auto_increment,
  `CustomerName` varchar(40),
  `CustomerPhone` varchar(20) ,
  `CustomerEmail` varchar(200),
  `CustomerAddress` varchar(60),
  primary key (CustomerID),
  unique key (CustomerPhone)
);


/* 2. 供應商 */
drop table if exists `Suppliers`;
create table `Suppliers`(
  `SupplierID` int auto_increment,
  `SupplierName` varchar(40),
  `SupplierPhone` varchar(20),
  `SupplierAddress` varchar(60),
  primary key (SupplierID),
  unique key (SupplierPhone)
);

/* 3. 商品表 */
drop table if exists `Products`;
create table `Products`(
  `ProductID` int auto_increment,
  `ProductName` varchar(40),
  `ProductNumber` varchar(20),
  `ProductPrice` varchar(200),
  `SupplierID` int,
  primary key (ProductID),
  foreign key (SupplierID) references Suppliers(SupplierID)
);

/* 4. 訂單 */
drop table if exists `Orders`;
create table `Orders`(
  `OrderID` int auto_increment,
  `OrderNumber` varchar(20),
  `CustomerID` int,
  primary key (OrderID),
  unique key (OrderNumber),
  foreign key (CustomerID) references Customers(CustomerID)
);

/* 5. 訂單細項 */
drop table if exists `OrderDetails`;
create table `OrderDetails`(
  `OrderDetailID` int auto_increment,
  `OrderNumber` varchar(20),
  `ProductID` int,
  `UnitPrice` int,
  `Quantity` int,
  primary key (OrderDetailID),
  foreign key (OrderNumber) references Orders(OrderNumber),
  foreign key (ProductID) references Products(ProductID)
);

desc `Customers`;
desc `Suppliers`;
desc `Products`;
desc `Orders`;
desc `OrderDetails`;

--------------------------------------
-- 功能
--------------------------------------

/* 6. 客戶 */
-- 新增
\d #
create procedure addCustomers(
  in CustomerName varchar(40),
  in CustomerPhone varchar(20) ,
  in CustomerEmail varchar(200),
  in CustomerAddress varchar(60)
)

begin
  declare exit handler for sqlstate '23000'
  begin
    select 'Error.';
  end;
  
  set @keyN = CustomerName;
  set @keyP = CustomerPhone;
  set @keyE = CustomerEmail;
  set @keyA = CustomerAddress;
  set @query = 'insert into `Customers`(`CustomerName`,`CustomerPhone`,`CustomerEmail`,`CustomerAddress`)values(?,?,?,?)';
  
  prepare stmt from @query;
  execute stmt using @keyN,@keyP,@keyE,@keyA;
  select 'Success add.';
end #
\d ;

-- 修改
\d #
create procedure updateCustomers(
  in CustomerID int,
  in colName varchar(20) ,
  in colData varchar(200)
)

begin
  set @query = '';
  set @keyC = colName;
  set @keyD = colData;
  set @keyI = CustomerID;
  
  if @keyC = 'CustomerName' then 
    set @query = 'update `Customers` set CustomerName = ? where id = ?';
  elseif @keyC = 'CustomerPhone' then 
    set @query = 'update `Customers` set CustomerPhone = ? where id = ?';
  elseif @keyC = 'CustomerEmail' then 
    set @query = 'update `Customers` set CustomerEmail = ? where id = ?';
  elseif @keyC = 'CustomerAddress' then 
    set @query = 'update `Customers` set CustomerAddress = ? where id = ?';
  else set @query = 'Error update.';
  end if;

  if @query != '' then 
    begin
      prepare stmt from @query;
      execute stmt using @keyD,@keyI;
      select 'Success update.';
    end;
  else select 'Error update.';
  end if;
end #
\d ;

-- 刪除
\d #
create procedure deleteCustomers(
  in CustomerID int
)

begin
  set @keyI = CustomerID;
  set @query = 'delete from `Customers` where id = ?';
  prepare stmt from @query;
  execute stmt using @keyI;
  select 'Success delete.';
end #
\d ;

-- 查詢電話
\d #
create procedure selectCustomerPhone(in CustomerPhone varchar(40))
begin
    set @key = concat('%', CustomerPhone, '%') COLLATE utf8_unicode_ci;
    set @query = 'select CustomerID,CustomerPhone from Customers where CustomerPhone like ?';

    prepare stmt from @query;
    execute stmt using @key;
end #
\d ;

-- 查詢姓名
\d #
create procedure selectCustomerName(in CustomerName varchar(20))
begin
    set @key = concat('%', CustomerName, '%') COLLATE utf8_unicode_ci;
    set @query = 'select CustomerName from Customers where CustomerName like ?';

    prepare stmt from @query;
    execute stmt using @key;
end #
\d ;

------------------------------------------------------------------
/* 7. 供應商 */
-- 新增
\d #
create procedure addSuppliers(
  in SupplierName varchar(40),
  in SupplierPhone varchar(20) ,
  in SupplierAddress varchar(60)
)

begin
  declare exit handler for sqlstate '23000'
  begin
    select 'Error.';
  end;
  
  set @keyN = SupplierName;
  set @keyP = SupplierPhone;
  set @keyA = SupplierAddress;
  set @query = 'insert into `Suppliers`(`SupplierName`,`SupplierPhone`,`SupplierAddress`)values(?,?,?)';
  
  prepare stmt from @query;
  execute stmt using @keyN,@keyP,@keyA;
  select 'Success add.';
end #
\d ;

-- 修改
\d #
create procedure updateSuppliers(
  in SupplierID int,
  in colName varchar(20) ,
  in colData varchar(200)
)

begin
  set @query = '';
  set @keyC = colName;
  set @keyD = colData;
  set @keyI = SupplierID;
  
  if @keyC = 'SupplierName' then 
    set @query = 'update `Suppliers` set SupplierName = ? where id = ?';
  elseif @keyC = 'SupplierPhone' then 
    set @query = 'update `Suppliers` set SupplierPhone = ? where id = ?';
  elseif @keyC = 'SupplierAddress' then 
    set @query = 'update `Suppliers` set SupplierAddress = ? where id = ?';
  else set @query = 'Error update.';
  end if;

  if @query != '' then 
    begin
      prepare stmt from @query;
      execute stmt using @keyD,@keyI;
      select 'Success update.';
    end;
  else select 'Error update.';
  end if;
end #
\d ;

-- 刪除
\d #
create procedure deleteSuppliers(
  in SupplierID int
)

begin
  set @keyI = SupplierID;
  set @query = 'delete from `Suppliers` where id = ?';
  prepare stmt from @query;
  execute stmt using @keyI;
  select 'Success delete.';
end #
\d ;

-- 查詢名稱
\d #
create procedure selectSupplierName(in SupplierName varchar(40))
begin
    set @key = concat('%', SupplierName, '%') COLLATE utf8_unicode_ci;
    set @query = 'select SupplierName from Suppliers where SupplierName like ?';

    prepare stmt from @query;
    execute stmt using @key;
end #
\d ;

-- 查詢電話
\d #
create procedure selectSupplierPhone(in SupplierPhone varchar(20))
begin
    set @key = concat('%', SupplierPhone, '%') COLLATE utf8_unicode_ci;
    set @query = 'select SupplierID,SupplierPhone from Suppliers where SupplierPhone like ?';

    prepare stmt from @query;
    execute stmt using @key;
end #
\d ;

------------------------------------------------------------------
/* 8. 商品 */
-- 新增
\d #
create procedure addProducts(
  in ProductName varchar(40),
  in ProductNumber varchar(20),
  in ProductPrice varchar(200),
  in SupplierID int
)

begin
  declare exit handler for sqlstate '23000'
  begin
    select 'Error.';
  end;

  set @keyN = ProductName;
  set @keyB = ProductNumber;
  set @keyP = ProductPrice;
  set @keySI = SupplierID;
  set @query = 'insert into `Products`(`ProductName`,`ProductNumber`,`ProductPrice`,`SupplierID`)values(?,?,?,?)';
  
  prepare stmt from @query;
  execute stmt using @keyN,@keyB,@keyP,@keySI;
  select 'Success add.';
end #
\d ;

-- 修改
\d #
create procedure updateProducts(
  in ProductID int,
  in colName varchar(20) ,
  in colData varchar(200)
)

begin
  set @query = '';
  set @keyC = colName;
  set @keyD = colData;
  set @keyI = ProductID;
  
  if @keyC = 'ProductName' then 
    set @query = 'update `Products` set ProductName = ? where id = ?';
  elseif @keyC = 'ProductNumber' then 
    set @query = 'update `Products` set ProductNumber = ? where id = ?';
  elseif @keyC = 'ProductPrice' then 
    set @query = 'update `Products` set ProductPrice = ? where id = ?';
  elseif @keyC = 'SupplierID' then 
    set @query = 'update `Products` set SupplierID = ? where id = ?';
  else set @query = 'Error update.';
  end if;

  if @query != '' then 
    begin
      prepare stmt from @query;
      execute stmt using @keyD,@keyI;
      select 'Success update.';
    end;
  else select 'Error update.';
  end if;
end #
\d ;

-- 刪除
\d #
create trigger deleteProducts before delete on `Suppliers` for each row
begin
    select count(*) into @temp from `Products` where `SupplierID` = old.SupplierID;
    if @temp != 0 then
        delete from `Products` where `SupplierID` = old.SupplierID;
    end if;
end #
\d ;


\d #
create procedure deleteProducts(
  in ProductID int
)

begin
  set @keyI = ProductID;
  set @query = 'delete from `Products` where id = ?';
  prepare stmt from @query;
  execute stmt using @keyI;
  select 'Success delete.';
end #
\d ;

-- 查詢名稱
\d #
create procedure selectProductName(in ProductName varchar(40))
begin
    set @key = concat('%', ProductName, '%') COLLATE utf8_unicode_ci;
    set @query = 'select ProductName from Products where ProductName like ?';

    prepare stmt from @query;
    execute stmt using @key;
end #
\d ;

------------------------------------------------------------------
/* 9. 訂單 */
-- 新增
\d #
create procedure addOrders(
  in OrderNumber varchar(20),
  in CustomerID int
)

begin
  declare exit handler for sqlstate '23000'
  begin
    select 'Error.';
  end;

  set @keyN = OrderNumber;
  set @keyCI = CustomerID;
  set @query = 'insert into `Orders`(`OrderNumber`,`CustomerID`)values(?,?)';
  
  prepare stmt from @query;
  execute stmt using @keyN,@keyCI;
  select 'Success add.';
end #
\d ;

-- 刪除
\d #
create trigger deleteOrdersFromCustomers before delete on `Customers` for each row
begin
  select count(*) into @temp from `Orders` where `CustomerID` = old.CustomerID;
  if @temp != 0 then
    delete from `Orders` where `CustomerID` = old.CustomerID;    
  end if;
end #
\d ;


\d #
create procedure deleteOrders(
  in OrderID int
)

begin
  set @keyI = OrderID;
  set @query = 'delete from `Orders` where id = ?';
  prepare stmt from @query;
  execute stmt using @keyI;
  select 'Success delete.';
end #
\d ;

------------------------------------------------------------------
/* 10.訂單明細 */
-- 新增
\d #
create procedure addOrderDetails(
  in OrderNumber varchar(20),
  in ProductID int,
  in UnitPrice int,
  in Quantity int
)

begin
  declare exit handler for sqlstate '23000'
  begin
    select 'Error.';
  end;

  set @keyN = OrderNumber;
  set @keyPI = ProductID;
  set @keyU = UnitPrice;
  set @keyQ = Quantity;
  set @query = 'insert into `OrderDetails`(`OrderNumber`,`ProductID`,`UnitPrice`,`Quantity`)values(?,?,?,?)';
  
  prepare stmt from @query;
  execute stmt using @keyN,@keyPI,@keyU,@keyQ;
  select 'Success add.';
end #
\d ;

-- 修改只修改數量及實際單價)
\d #
create procedure updateOrderDetails(
  in OrderDetailID int,
  in colName varchar(20) ,
  in colData varchar(200)
)

begin
  set @query = '';
  set @keyC = colName;
  set @keyD = colData;
  set @keyI = OrderDetailID;
  
  if  @keyC = 'UnitPrice' then 
    set @query = 'update `OrderDetails` set UnitPrice = ? where id = ?';
  elseif @keyC = 'Quantity' then 
    set @query = 'update `OrderDetails` set Quantity = ? where id = ?';
  end if;

  if @query != '' then 
    begin
      prepare stmt from @query;
      execute stmt using @keyD,@keyI;
      select 'Success update.';
    end;
  else select 'Error update.';
  end if;
end #
\d ;

-- 刪除
\d #
create trigger deleteOrderDetails before delete on `Orders` for each row
begin
    select count(*) into @temp from `OrderDetails` where `OrderNumber` = old.OrderNumber;
    if @temp != 0 then
        delete from `OrderDetails` where `OrderNumber` = old.OrderNumber;
    end if;
end #
\d ;


\d #
create procedure deleteOrderDetails(
  in OrderNumber int
)

begin
  set @keyN = OrderNumber;
  set @query = 'delete from `OrderDetails` where id = ?';
  prepare stmt from @query;
  execute stmt using @keyN;
  select 'Success delete.';
end #
\d ;

------------------------------------------------------------------
/* 11. 綜合查詢 */
-- a. 指定客戶查詢訂單,含訂單明細
\d #
create procedure selectOrderDetailofCustomer(
  in CustomerName varchar(40)
)

begin
    set @key = CustomerName;
    set @query = '
    select c.CustomerName,o.OrderNumber,p.ProductID,od.UnitPrice,od.Quantity 
    from Customers c,Orders o,Products p,OrderDetails od 
    where c.CustomerID=o.CustomerID and od.ProductID=p.ProductID and o.OrderNumber=od.OrderNumber and c.CustomerName=? order by c.CustomerName;
    ' ;

    prepare stmt from @query;
    execute stmt using @key;
end #
\d ;

-- b. 指定客戶查詢訂單總金額
\d #
create procedure selectOrderTotalofCustomer(
  in CustomerName varchar(40)
)

begin
    set @key = CustomerName;
    set @query = '
    select c.CustomerName,o.OrderID,sum(od.UnitPrice*od.Quantity) total 
    from Customers c,Orders o,OrderDetails od 
    where c.CustomerID=o.CustomerID and o.OrderNumber=od.OrderNumber and c.CustomerName=? group by o.OrderID;
    ' ;

    prepare stmtp from @query;
    execute stmtp using @key;
end #
\d ;

-- c. 指定商品查詢訂單中的客戶, 例如: 商品P001的客戶有哪些,買幾個
\d #
create procedure selectOrderCustomerofProduct(
  in ProductName varchar(40)
)

begin
    set @key = ProductName;
    set @query = '
    select p.ProductName,c.CustomerName,od.Quantity 
    from Customers c,Orders o,Products p,OrderDetails od 
    where c.CustomerID=o.CustomerID and od.ProductID=p.ProductID and o.OrderNumber=od.OrderNumber and p.ProductName=? order by p.ProductName;
    ' ;

    prepare stmtp from @query;
    execute stmtp using @key;
end #
\d ;

-- d. 指定供應商查詢訂單中的商品清單
\d #
create procedure selectOrderListofSupplier(
  in SupplierName varchar(40)
)

begin
    set @key = SupplierName;
    set @query = '
    select s.SupplierName,o.OrderID,p.ProductName 
    from Suppliers s,Orders o,Products p,OrderDetails od 
    where s.SupplierID=p.SupplierID and od.ProductID=p.ProductID and o.OrderNumber=od.OrderNumber and SupplierName=? order by SupplierName;
    ' ;

    prepare stmtp from @query;
    execute stmtp using @key;
end #
\d ;


