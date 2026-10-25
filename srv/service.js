const cds = require('@sap/cds');
const { SELECT, UPDATE } = require('@sap/cds/lib/ql/cds-ql');

module.exports = cds.service.impl(function () {

    const { PurchaseOrders, OrderItems } = this.entities

    this.after(['CREATE', 'UPDATE'], "OrderItems.drafts", async (req) => {

        if (req.quantity && req.quantity > 0) {
           
            const currentOrderItems = await SELECT
                .from(OrderItems.drafts)
                .where({ purchaseOrderId: req.purchaseOrderId })

            let totalAmount = 0
            currentOrderItems.forEach(element => {
                element.itemTotal = element.quantity * element.unitPrice;
                totalAmount += element.itemTotal;
               if(element.orderItemID === req.orderItemID){
                req.itemTotal = element.itemTotal;
               }
            });

             await UPDATE(OrderItems.drafts)
                    .set({ itemTotal: req.itemTotal })
                    .where({ orderItemID: req.orderItemID });
                

            await UPDATE(PurchaseOrders.drafts)
                .set({ totalAmount })
                .where({ purchaseOrderId: req.purchaseOrderId });
        }

    })

})