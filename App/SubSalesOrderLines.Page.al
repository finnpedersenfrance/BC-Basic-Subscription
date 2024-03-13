namespace FinnPedersenFrance.BasicSubscriptionManagement;

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
                    ToolTip = 'Specifies the Document Type.';
                }
                field(SelltoCustomerNo; Rec."Sell-to Customer No.")
                {
                    ToolTip = 'Specifies the Sell-to Customer No.';
                }
                field(DocumentNo; Rec."Document No.")
                {
                    ToolTip = 'Specifies the Document No.';
                }
                field(LineNo; Rec."Line No.")
                {
                    ToolTip = 'Specifies the Line No.';
                }
                field(Type; Rec.Type)
                {
                    ToolTip = 'Specifies the Type.';
                }
                field(No; Rec."No.")
                {
                    ToolTip = 'Specifies the No.';
                }
                field(SubscriptionType; Rec."Subscription Type")
                {
                    ToolTip = 'Specifies the Subscription Type.';
                }
                field(SubscriptionPeriodicity; Rec."Subscription Periodicity")
                {
                    ToolTip = 'Specifies the Subscription Periodicity.';
                }
                field(ShipmentDate; Rec."Shipment Date")
                {
                    ToolTip = 'Specifies the Shipment Date.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the Description.';
                }
                field(UnitofMeasure; Rec."Unit of Measure")
                {
                    ToolTip = 'Specifies the Unit of Measure.';
                }
                field(Quantity; Rec.Quantity)
                {
                    ToolTip = 'Specifies the Quantity.';
                }
                field(QtytoShip; Rec."Qty. to Ship")
                {
                    ToolTip = 'Specifies the Qty. to Ship.';
                }
                field(UnitPrice; Rec."Unit Price")
                {
                    ToolTip = 'Specifies the Unit Price.';
                }
                field(LineDiscount; Rec."Line Discount %")
                {
                    ToolTip = 'Specifies the Line Discount %.';
                }
                field(LineDiscountAmount; Rec."Line Discount Amount")
                {
                    ToolTip = 'Specifies the Line Discount Amount.';
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the Amount.';
                }
                field(QuantityInvoiced; Rec."Quantity Invoiced")
                {
                    ToolTip = 'Specifies the Quantity Invoiced.';
                }
                field(CurrencyCode; Rec."Currency Code")
                {
                    ToolTip = 'Specifies the Currency Code.';
                }
            }
        }
    }
}
