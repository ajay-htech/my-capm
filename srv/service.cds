using mydb from '../db/schema';

service ProductService {
    entity Products as projection on mydb.Products;
    entity Customers as projection on mydb.Customers;
    entity Employees as projection on mydb.Employees;
    @odata.draft.enabled
    entity PurchaseOrders as projection on mydb.PurchaseOrders;
    entity Attachments as projection on mydb.Attachments;
}
