namespace FinnPedersenFrance.BasicSubscriptionManagement;

using Microsoft.Inventory.Item;

pageextension 50141 "Subscription Item List" extends "Item List"
{
    layout
    {
        addafter(Description)
        {
            field("Subscription Type"; Rec."Subscription Type")
            {
                ApplicationArea = All;
                ToolTip = 'Subscription Type';
            }

            field("Subscription Periodicity"; Rec."Subscription Periodicity")
            {
                ApplicationArea = All;
                ToolTip = 'Subscription Periodicity';
            }
        }
    }
}