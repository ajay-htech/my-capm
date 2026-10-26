namespace mydb;

using {
    managed,
    cuid
} from '@sap/cds/common';

annotate PurchaseOrders with {
    modifiedAt @odata.etag;
};

entity Products {
    key productId       : Integer;
        productName     : String(255);
        categoryId      : Integer;
        supplierId      : Integer;
        quantityPerUnit : String(100);
        unitPrice       : Double;
        unitsInStock    : Integer;
        unitsOnOrder    : Integer;
        reorderLevel    : Integer;
        discontinued    : Boolean;
}

entity Customers {
    key customerId   : String(10);
        companyName  : String(255);
        contactName  : String(255);
        contactTitle : String(100);
        address      : String(255);
        city         : String(100);
        region       : String(100);
        postalCode   : String(20);
        country      : String(100);
        phone        : String(50);
        fax          : String(50);
}

entity Employees {
    key employeeId      : Integer;
        firstName       : String(100);
        lastName        : String(100);
        title           : String(100);
        titleOfCourtesy : String(50);
        birthDate       : Date;
        hireDate        : Date;
        address         : String(255);
        city            : String(100);
        region          : String(100);
        postalCode      : String(20);
        country         : String(100);
        homePhone       : String(50);
        extension       : String(20);
        photoPath       : String(500);
        notes           : LargeString;
        reportsTo       : Integer;
}

entity PurchaseOrders : managed {
    key purchaseOrderId : UUID;

        customerId      : String(10);
        totalAmount     : Double;
        approvalStatus  : String;

        orderItems      : Composition of many OrderItems
                              on orderItems.purchaseOrderId = purchaseOrderId;

        approvals       : Composition of many ApprovalTable
                              on approvals.purchaseOrderId = purchaseOrderId;
}

entity OrderItems {
    key orderItemID     : UUID;
        purchaseOrderId : UUID;
        productId       : Integer;
        productName     : String;
        quantity        : Integer;
        unitPrice       : Double;
        itemTotal       : Double;
        purchaseOrder   : Association to PurchaseOrders
                              on purchaseOrder.purchaseOrderId = purchaseOrderId;

        product         : Association to one Products
                              on product.productId = productId;
}


entity ApprovalTable : cuid {
    approvalLevel   : String;
    approver        : String;
    mailId          : String;
    respondedOn     : DateTime;
    purchaseOrderId : UUID;
    remarks         : String(1000);

    purchaseOrder   : Association to one PurchaseOrders
                          on purchaseOrder.purchaseOrderId = purchaseOrderId;
}
entity LevelSHelp  {
    key level : String;
     description: String;
}
entity Approvers {
    key mailId      : String;
        name        : String;
        Designation : String;
}

entity Attachments : cuid, managed {

    fileName      : String(255);

    mimeType      : String(100);

    fileSize      : Integer;

    content       : LargeBinary
    @Core.MediaType                  : mimeType
    @Core.ContentDisposition.Filename: fileName;

    purchaseOrder : Association to PurchaseOrders;
}
