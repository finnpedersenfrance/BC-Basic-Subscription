namespace FinnPedersenFrance.App.BasicSubscriptionManagement;

using Microsoft.Inventory.Item;

pageextension 50140 "FPFr Subscription Item Card" extends "Item Card"
{
    layout
    {
        addafter(Item)
        {
            group(Subscription)
            {
                field("Subscription type"; Rec."Subscription type")
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
}