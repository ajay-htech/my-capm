using mydb from '../db/schema';




annotate ProductService.OrderItems with @(
    Common.SideEffects #CalculateIteamTotal: {
        SourceProperties : ['quantity'],
        TargetProperties : ['itemTotal'],
    }
);
annotate ProductService.PurchaseOrders with @(
    Common.SideEffects #RecalculateTotal : {
        SourceEntities  : ['orderItems'],
        TargetProperties: ['totalAmount']
    }
);



service ProductService {

    entity Products as projection on mydb.Products;
    entity Customers as projection on mydb.Customers;
    entity Employees as projection on mydb.Employees;
    @odata.draft.enabled
    entity PurchaseOrders as projection on mydb.PurchaseOrders;
    entity OrderItems as projection on mydb.OrderItems;
    entity Attachments as projection on mydb.Attachments;
}
