namespace myapps.smartcontrols;
using { managed } from '@sap/cds/common';

@assert.range
type operators : String enum { NA; ![<]; ![>];![=];![<=];![>=]; } 

entity autoapproval {
    key ID: UUID;
    operator: operators 
}


entity Product {
    key ProductID       : Integer;
        ProductName     : String(40);
        SupplierID      : Integer;
        CategoryID      : Integer;
        QuantityPerUnit : String(20);
        UnitPrice       : Decimal(19, 4);
        UnitsInStock    : Integer;
        UnitsOnOrder    : Integer;
        ReorderLevel    : Integer;
        Discontinued    : Boolean;
}

entity Category {
    key CategoryID   : Integer;
        CategoryName : String(15);
        Description  : String;
        Picture      : Binary;
}

entity Supplier {
    key SupplierID: Integer;
    CompanyName:String(40);
    ContactName:String(30);
    ContactTitle:String(30);
    Address:String(60);
    City:String(15);
    Region:String(15);
    PostalCode:String(10);
    Country:String(15);
    Phone:String(24);
    Fax:String(24);
    HomePage:String;
}

entity managedEmployees : managed {    
    key empID : Integer;
    empName: String(20); 
    empAge: Integer;
}

view getEmployee1(p_emp : String(20)) as
    select key empID,
    empName,
    empAge
    from managedEmployees 
    where LTRIM(empName,'0') = : p_emp;

view getEmployee2(p_emp : String(20)) as
    select key empID,
    empName,
    empAge
    from managedEmployees 
    where empName = LPAD(: p_emp,4,'0');

view uniontest as 
select key p.ProductID, p.CategoryID, c.CategoryName from Product as p 
inner join Category as c 
on c.CategoryID = p.CategoryID;