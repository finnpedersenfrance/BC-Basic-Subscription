Page 50140 "FPFr Sub. Sales Order Lines"
{
    Caption = 'Subscription Sales Order Lines';
    PageType = List;
    SourceTable = "Sales Line";
    SourceTableView = where("Document Type" = const("Blanket Order"),
                            "Subscription Type" = filter(Recurring | Stop));
    UsageCategory = None;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(DocumentType; Rec."Document Type")
                {
                    ToolTip = 'Document Type';
                    ApplicationArea = All;
                }
                field(SelltoCustomerNo; Rec."Sell-to Customer No.")
                {
                    ToolTip = 'Sell-to Customer No.';
                    ApplicationArea = All;
                }
                field(DocumentNo; Rec."Document No.")
                {
                    ToolTip = 'Document No.';
                    ApplicationArea = All;
                }
                field(LineNo; Rec."Line No.")
                {
                    ToolTip = 'Line No.';
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
                {
                    ToolTip = 'Type';
                    ApplicationArea = All;
                }
                field(No; Rec."No.")
                {
                    ToolTip = 'No.';
                    ApplicationArea = All;
                }
                field(SubscriptionType; Rec."Subscription Type")
                {
                    ToolTip = 'Subscription Type';
                    ApplicationArea = All;
                }
                field(SubscriptionPeriodicity; Rec."Subscription Periodicity")
                {
                    ToolTip = 'Subscription Periodicity';
                    ApplicationArea = All;
                }
                field(ShipmentDate; Rec."Shipment Date")
                {
                    ToolTip = 'Shipment Date';
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Description';
                    ApplicationArea = All;
                }
                field(UnitofMeasure; Rec."Unit of Measure")
                {
                    ToolTip = 'Unit of Measure';
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ToolTip = 'Quantity';
                    ApplicationArea = All;
                }
                field(QtytoShip; Rec."Qty. to Ship")
                {
                    ToolTip = 'Qty. to Ship';
                    ApplicationArea = All;
                }
                field(UnitPrice; Rec."Unit Price")
                {
                    ToolTip = 'Unit Price';
                    ApplicationArea = All;
                }
                field(LineDiscount; Rec."Line Discount %")
                {
                    ToolTip = 'Line Discount %';
                    ApplicationArea = All;
                }
                field(LineDiscountAmount; Rec."Line Discount Amount")
                {
                    ToolTip = 'Line Discount Amount';
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Amount';
                    ApplicationArea = All;
                }
                field(QuantityInvoiced; Rec."Quantity Invoiced")
                {
                    ToolTip = 'Quantity Invoiced';
                    ApplicationArea = All;
                }
                field(CurrencyCode; Rec."Currency Code")
                {
                    ToolTip = 'Currency Code';
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

