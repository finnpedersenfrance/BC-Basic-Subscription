PageExtension 50142 "FPFr Sub. Order Subform" extends "Blanket Sales Order Subform"
{
    layout
    {
        addafter("Shipment Date")
        {
            field("Subscription Type"; Rec."Subscription Type")
            {
                ToolTip = 'Subscription Type';
                ApplicationArea = All;
            }

            field("Subscription Periodicity"; Rec."Subscription Periodicity")
            {
                ToolTip = 'Subscription Periodicity';
                ApplicationArea = All;
            }

        }
    }
}

