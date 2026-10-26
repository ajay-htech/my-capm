const cds = require('@sap/cds');
const { SELECT, UPDATE } = require('@sap/cds/lib/ql/cds-ql');

module.exports = cds.service.impl(function () {

    const { PurchaseOrders, OrderItems, ApprovalTable } = this.entities

    this.after('UPDATE', "OrderItems.drafts", async (req) => {

        if (req.quantity && req.quantity > 0) {

            const currentOrderItems = await SELECT
                .from(OrderItems.drafts)
                .where({ purchaseOrderId: req.purchaseOrderId })

            let totalAmount = 0
            currentOrderItems.forEach(element => {
                element.itemTotal = element.quantity * element.unitPrice;
                totalAmount += element.itemTotal;
                if (element.orderItemID === req.orderItemID) {
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

    });
    this.before('UPDATE', "ApprovalTable.drafts", async (req, next) => {

        if (req.data.approvalLevel) {
            const purchaseOrderId = req.data.purchaseOrderId;

            await UPDATE(ApprovalTable.drafts)
                .set({ approvalLevel: req.data.approvalLevel })
                .where({ ID: req.data.ID });

            const approvals = await SELECT
                .from(ApprovalTable.drafts)
                .where({ purchaseOrderId })
                .columns('approvalLevel');

            const levels = approvals
                .map(a => a.approvalLevel)
                .sort((a, b) => a - b);

            for (let i = 0; i < levels.length; i++) {
                const level = i + 1;
                const expectedLevel = "L" + level;

                if (levels[i] !== expectedLevel) {
                    req.error(
                        400,
                        `Approval Level ${expectedLevel} is missing. Please assign approvers sequentially.`
                    );
                    return;
                }
            }
        }
    });

})