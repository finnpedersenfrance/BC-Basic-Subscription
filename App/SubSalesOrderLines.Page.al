namespace FinnPedersenFrance.App.BasicSubscriptionManagement;

using Microsoft.Sales.Document;

page 50140 "Sub. Sales Order Lines"
{
    ApplicationArea = All;
    Caption = 'Subscription Sales Order Lines';
    PageType = List;
    SourceTable = "Sales Line";
    SourceTableView = where("Document Type" = const("Blanket Order"),
                            "Subscription Type" = filter(Recurring | Stop));
    UsageCategory = None;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(DocumentType; Rec."Document Type")
                {
                    ToolTip = 'Document Type';
                }
                field(SelltoCustomerNo; Rec."Sell-to Customer No.")
                {
                    ToolTip = 'Sell-to Customer No.';
                }
                field(DocumentNo; Rec."Document No.")
                {
                    ToolTip = 'Document No.';
                }
                field(LineNo; Rec."Line No.")
                {
                    ToolTip = 'Line No.';
                }
                field(Type; Rec.Type)
                {
                    ToolTip = 'Type';
                }
                field(No; Rec."No.")
                {
                    ToolTip = 'No.';
                }
                field(SubscriptionType; Rec."Subscription Type")
                {
                    ToolTip = 'Subscription Type';
                }
                field(SubscriptionPeriodicity; Rec."Subscription Periodicity")
                {
                    ToolTip = 'Subscription Periodicity';
                }
                field(ShipmentDate; Rec."Shipment Date")
                {
                    ToolTip = 'Shipment Date';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Description';
                }
                field(UnitofMeasure; Rec."Unit of Measure")
                {
                    ToolTip = 'Unit of Measure';
                }
                field(Quantity; Rec.Quantity)
                {
                    ToolTip = 'Quantity';
                }
                field(QtytoShip; Rec."Qty. to Ship")
                {
                    ToolTip = 'Qty. to Ship';
                }
                field(UnitPrice; Rec."Unit Price")
                {
                    ToolTip = 'Unit Price';
                }
                field(LineDiscount; Rec."Line Discount %")
                {
                    ToolTip = 'Line Discount %';
                }
                field(LineDiscountAmount; Rec."Line Discount Amount")
                {
                    ToolTip = 'Line Discount Amount';
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Amount';
                }
                field(QuantityInvoiced; Rec."Quantity Invoiced")
                {
                    ToolTip = 'Quantity Invoiced';
                }
                field(CurrencyCode; Rec."Currency Code")
                {
                    ToolTip = 'Currency Code';
                }
            }
        }
    }
}
