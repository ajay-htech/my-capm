namespace mydb;

using {managed,cuid} from '@sap/cds/common';


annotate PurchaseOrders with { modifiedAt @odata.etag }

entity Products {
    key ProductID       : Integer;
        ProductName     : String(255);
        CategoryID      : Integer;
        SupplierID      : Integer;
        QuantityPerUnit : String(100);
        UnitPrice       : Double;
        UnitsInStock    : Integer;
        UnitsOnOrder    : Integer;
        ReorderLevel    : Integer;
        Discontinued    : Boolean;
}

entity Customers {
    key CustomerID   : String(10);
        CompanyName  : String(255);
        ContactName  : String(255);
        ContactTitle : String(100);
        Address      : String(255);
        City         : String(100);
        Region       : String(100);
        PostalCode   : String(20);
        Country      : String(100);
        Phone        : String(50);
        Fax          : String(50);
}

entity Employees {
    key EmployeeID      : Integer;
        FirstName       : String(100);
        LastName        : String(100);
        Title           : String(100);
        TitleOfCourtesy : String(50);
        BirthDate       : Date;
        HireDate        : Date;
        Address         : String(255);
        City            : String(100);
        Region          : String(100);
        PostalCode      : String(20);
        Country         : String(100);
        HomePhone       : String(50);
        Extension       : String(20);
        PhotoPath       : String(500);
        Notes           : LargeString;
        ReportsTo       : Integer;
}

entity PurchaseOrders : managed {
    key PurchaseOrderID : UUID;
        CustomerID      : String(10);
        TotalAmount     : Double;
        PoToOiderItems  : Composition of many OrderItems
                              on PoToOiderItems.PurchaseOrderID = PurchaseOrderID;
}

entity OrderItems {
    key OrderItemID       : UUID;
        PurchaseOrderID   : UUID;
        ProductID         : Integer;
        ProductName       : String;
        Quantity          : Integer;
        UnitPrice         : Double;
        OitoPurchaseOrder : Association to PurchaseOrders
                                on OitoPurchaseOrder.PurchaseOrderID = PurchaseOrderID;
        OiToProducts      : Association to one Products
                                on OiToProducts.ProductID = ProductID;
}



entity Attachments : cuid, managed {

    fileName        : String(255);

    mimeType        : String(100);

    fileSize        : Integer;

    content         : LargeBinary
        @Core.MediaType : mimeType
        @Core.ContentDisposition.Filename : fileName;

    purchaseOrder   : Association to PurchaseOrders;
}
