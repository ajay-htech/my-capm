using ProductService as service from '../../srv/service';
using from '../../db/schema';

annotate service.PurchaseOrders with @(
    UI.FieldGroup #GeneratedGroup : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Label : 'CustomerID',
                Value : CustomerID,
            },
            {
                $Type : 'UI.DataField',
                Label : 'TotalAmount',
                Value : TotalAmount,
            },
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Order Details',
            ID : 'OrderDetails',
            Target : '@UI.FieldGroup#OrderDetails',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Items Section',
            ID : 'ItemsSection',
            Target : 'orderItems/@UI.LineItem#ItemsSection',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Approvers Table',
            ID : 'ApproversTable',
            Target : 'approvals/@UI.LineItem#ApproversTable',
        },
    ],
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : purchaseOrderId,
            Label : 'Purchase Order Id',
        },
        {
            $Type : 'UI.DataField',
            Value : customerId,
            Label : 'Customer Id',
        },
        {
            $Type : 'UI.DataField',
            Value : totalAmount,
            Label : 'Total Amount',
        },
        {
            $Type : 'UI.DataField',
            Value : approvalStatus,
            Label : 'Approval Status',
        },
    ],
    UI.FieldGroup #OrderDetails : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : purchaseOrderId,
                Label : 'purchaseOrderId',
            },
            {
                $Type : 'UI.DataField',
                Value : approvalStatus,
                Label : 'approvalStatus',
            },
            {
                $Type : 'UI.DataField',
                Value : createdAt,
            },
            {
                $Type : 'UI.DataField',
                Value : createdBy,
            },
            {
                $Type : 'UI.DataField',
                Value : customerId,
                Label : 'customerId',
            },
            {
                $Type : 'UI.DataField',
                Value : modifiedAt,
            },
            {
                $Type : 'UI.DataField',
                Value : modifiedBy,
            },
            {
                $Type : 'UI.DataField',
                Value : totalAmount,
                Label : 'totalAmount',
            },
        ],
    },
);

annotate service.PurchaseOrders with @UI.HeaderInfo : {
    TypeName       : 'PO',
    TypeNamePlural : 'Purchase Orders'
};
annotate service.OrderItems with @(
    UI.LineItem #ItemsSection : [
        {
            $Type : 'UI.DataField',
            Value : productName,
            Label : 'productName',
        },
        {
            $Type : 'UI.DataField',
            Value : quantity,
            Label : 'quantity',
        },
        {
            $Type : 'UI.DataField',
            Value : unitPrice,
            Label : 'unitPrice',
        },
        {
            $Type : 'UI.DataField',
            Value : itemTotal,
            Label : 'itemTotal',
        },
    ]
);

annotate service.ApprovalTable with @(
    UI.LineItem #ApproversTable : [
        {
            $Type : 'UI.DataField',
            Value : approver,
            Label : 'approver',
        },
        {
            $Type : 'UI.DataField',
            Value : approvalLevel,
            Label : 'approvalLevel',
        },
        {
            $Type : 'UI.DataField',
            Value : remarks,
            Label : 'remarks',
        },
        {
            $Type : 'UI.DataField',
            Value : respondedOn,
            Label : 'respondedOn',
        },
    ]
);

annotate service.OrderItems with {
    productName @(
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Products',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : productName,
                    ValueListProperty : 'productName',
                },
                {
                    $Type : 'Common.ValueListParameterInOut',
                    ValueListProperty : 'unitPrice',
                    LocalDataProperty : unitPrice,
                },
            ],
            Label : 'Item Details',
        },
        Common.ValueListWithFixedValues : true,
        Common.FieldControl : #Mandatory,
)};

annotate service.Products with {
    productName @(
        Common.Text : quantityPerUnit,
        Common.Text.@UI.TextArrangement : #TextLast,
    )
};

annotate service.ApprovalTable with {
    approver @(
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Approvers',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : approver,
                    ValueListProperty : 'name',
                },
                {
                    $Type : 'Common.ValueListParameterInOut',
                    ValueListProperty : 'mailId',
                    LocalDataProperty : mailId,
                },
            ],
            Label : 'Approvers',
        },
        Common.ValueListWithFixedValues : false,
        Common.FieldControl : #Mandatory,
)};

annotate service.Approvers with {
    name @Common.Text : Designation
};

annotate service.ApprovalTable with {
    approvalLevel @(
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'LeavelSHelp',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : approvalLevel,
                    ValueListProperty : 'level',
                },
            ],
            Label : 'Level',
        },
        Common.ValueListWithFixedValues : true,
        Common.FieldControl : #Mandatory,
)};

annotate service.LeavelSHelp with {
    level @Common.Text : description
};

annotate service.PurchaseOrders with {
    customerId @(
        Common.FieldControl : #Mandatory,
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Customers',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : customerId,
                    ValueListProperty : 'customerId',
                },
            ],
            Label : 'Customers',
        },
        Common.ValueListWithFixedValues : true,
    )
};

annotate service.OrderItems with {
    itemTotal @Common.FieldControl : #ReadOnly
};


annotate service.OrderItems with {
    quantity @Common.FieldControl : #Mandatory
};

annotate service.Customers with {
    customerId @Common.Text : companyName
};

annotate service.PurchaseOrders with {
    approvalStatus @Common.FieldControl : #ReadOnly
};


annotate service.ApprovalTable with {
    remarks @Common.FieldControl : #ReadOnly
};

annotate service.PurchaseOrders with {
    totalAmount @(
        Common.FieldControl : #ReadOnly,
        Measures.ISOCurrency : 'INR',
    )
};

