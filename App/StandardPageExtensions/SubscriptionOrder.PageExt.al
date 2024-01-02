namespace FinnPedersenFrance.App.BasicSubscriptionManagement;

using Microsoft.Sales.Document;

pageextension 50143 "Subscription Order" extends "Blanket Sales Order"
{
    actions
    {
        addafter(Approval)
        {
            group(Subscription)
            {
                Caption = 'Subscription';
                action("Calculate Quantity to Ship")
                {
                    ApplicationArea = All;
                    Caption = 'Calculate Quantity to Ship';
                    Image = CalculatePlan;
                    ToolTip = 'Calculate Quantity to Ship';

                    trigger OnAction()
                    var
                        SubscriptionManagement: Codeunit "Subscription Management";
                    begin
                        SubscriptionManagement.CalculateQuantityToShipYN(Rec);
                    end;
                }
                action(MakeOrders)
                {
                    ApplicationArea = All;
                    Caption = 'Make Order';
                    Image = MakeOrder;
                    ToolTip = 'Make Orders';

                    trigger OnAction()
                    var
                        SubscriptionManagement: Codeunit "Subscription Management";
                    begin
                        SubscriptionManagement.MakeOrderYN(Rec);
                    end;
                }
                action("Calculate Next Subscription Period")
                {
                    ApplicationArea = All;
                    Caption = 'Calculate Next Subscription Period';
                    Image = CalculatePlan;
                    ToolTip = 'Calculate Next Subscription Period';

                    trigger OnAction()
                    var
                        SubscriptionManagement: Codeunit "Subscription Management";
                    begin
                        SubscriptionManagement.CalculateNextSubscriptionPeriodYN(Rec);
                    end;
                }
            }
        }
    }
}
