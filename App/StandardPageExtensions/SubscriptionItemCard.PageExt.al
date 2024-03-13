namespace FinnPedersenFrance.BasicSubscriptionManagement;

using Microsoft.Inventory.Item;

pageextension 50140 "Subscription Item Card" extends "Item Card"
{
    layout
    {
        addafter(Item)
        {
            group(Subscription)
            {
                Caption = 'Subscription';
                field("Subscription type"; Rec."Subscription Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the type of Subscription.';
                }
                field("Subscription Periodicity"; Rec."Subscription Periodicity")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Subscription Periodicity.';
                }
            }
        }
    }
}