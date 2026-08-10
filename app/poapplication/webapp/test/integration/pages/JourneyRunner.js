sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"poapplication/test/integration/pages/PurchaseOrdersList.gen",
	"poapplication/test/integration/pages/PurchaseOrdersObjectPage.gen",
	"poapplication/test/integration/pages/OrderItemsObjectPage.gen"
], function (JourneyRunner, PurchaseOrdersListGenerated, PurchaseOrdersObjectPageGenerated, OrderItemsObjectPageGenerated) {
    'use strict';

    const runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('poapplication') + '/test/flp.html#app-preview',
        pages: {
			onThePurchaseOrdersListGenerated: PurchaseOrdersListGenerated,
			onThePurchaseOrdersObjectPageGenerated: PurchaseOrdersObjectPageGenerated,
			onTheOrderItemsObjectPageGenerated: OrderItemsObjectPageGenerated
        },
        async: true
    });

    return runner;
});

