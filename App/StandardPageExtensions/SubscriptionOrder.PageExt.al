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
                    ToolTip = 'Calculate Quantity to Ship';
                    ApplicationArea = All;
                    Caption = 'Calculate Quantity to Ship';
                    Image = CalculatePlan;

                    trigger OnAction()
                    var
                        FPFrSubscriptionManagement: Codeunit "Subscription Management";
                    begin
                        FPFrSubscriptionManagement.CalculateQuantityToShipYN(Rec);
                    end;
                }
                action(MakeOrders)
                {
                    ToolTip = 'Make Orders';
                    ApplicationArea = All;
                    Caption = 'Make Order';
                    Image = MakeOrder;

                    trigger OnAction()
                    var
                        FPFrSubscriptionManagement: Codeunit "Subscription Management";
                    begin
                        FPFrSubscriptionManagement.MakeOrderYN(Rec);
                    end;
                }
                action("Calculate Next Subscription Period")
                {
                    ToolTip = 'Calculate Next Subscription Period';
                    ApplicationArea = All;
                    Caption = 'Calculate Next Subscription Period';
                    Image = CalculatePlan;

                    trigger OnAction()
                    var
                        FPFrSubscriptionManagement: Codeunit "Subscription Management";
                    begin
                        FPFrSubscriptionManagement.CalculateNextSubscriptionPeriodYN(Rec);
                    end;
                }
            }
        }
    }
}
