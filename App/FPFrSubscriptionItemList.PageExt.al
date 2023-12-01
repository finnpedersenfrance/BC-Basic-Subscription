pageextension 50141 "FPFr Subscription Item List" extends "Item List"
{
    layout
    {
        addafter(Description)
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