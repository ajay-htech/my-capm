using mydb from '../db/schema';

service ProductServiceV2 {
    entity Products as projection on mydb.Products;
    entity Customers as projection on mydb.Customers;
    entity Employees as projection on mydb.Employees;
    entity PurchaseOrders as projection on mydb.PurchaseOrders;
    entity Attachments as projection on mydb.Attachments;
}