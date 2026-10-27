using mydb from '../db/schema';



service ProductService {

    entity Products       as projection on mydb.Products;
    entity Customers      as projection on mydb.Customers;
    entity Employees      as projection on mydb.Employees;

    @odata.draft.enabled
    entity PurchaseOrders as projection on mydb.PurchaseOrders
        actions {
           action sendForApproval() returns String;
        };

    entity OrderItems     as projection on mydb.OrderItems;
    entity ApprovalTable  as projection on mydb.ApprovalTable;
    entity Approvers      as projection on mydb.Approvers;
    entity LeavelSHelp    as projection on mydb.LevelSHelp;
    entity Attachments    as projection on mydb.Attachments;
}
