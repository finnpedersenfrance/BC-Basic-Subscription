namespace FinnPedersenFrance.App.BasicSubscriptionManagement;

using Microsoft.Inventory.Item;

pageextension 50141 "Subscription Item List" extends "Item List"
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