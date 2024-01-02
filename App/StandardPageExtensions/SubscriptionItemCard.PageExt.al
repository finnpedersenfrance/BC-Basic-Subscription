namespace FinnPedersenFrance.App.BasicSubscriptionManagement;

using Microsoft.Inventory.Item;

pageextension 50140 "Subscription Item Card" extends "Item Card"
{
    layout
    {
        addafter(Item)
        {
            group(Subscription)
            {
                field("Subscription type"; Rec."Subscription Type")
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
}