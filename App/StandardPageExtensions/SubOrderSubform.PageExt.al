namespace FinnPedersenFrance.BasicSubscriptionManagement;

using Microsoft.Sales.Document;

pageextension 50142 "Sub. Order Subform" extends "Blanket Sales Order Subform"
{
    layout
    {
        addafter("Shipment Date")
        {
            field("Subscription Type"; Rec."Subscription Type")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the Subscription Type.';
            }

            field("Subscription Periodicity"; Rec."Subscription Periodicity")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the Subscription Periodicity.';
            }
        }
    }
}
