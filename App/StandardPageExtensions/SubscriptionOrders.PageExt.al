namespace FinnPedersenFrance.BasicSubscriptionManagement;

using Microsoft.Sales.Document;

pageextension 50144 "Subscription Orders" extends "Blanket Sales Orders"
{
    actions
    {
        addafter("Request Approval")
        {
            group(Subscription)
            {
                Caption = 'Subscription';
                action(CalculateQuantitytoShip)
                {
                    ApplicationArea = All;
                    Caption = 'Calculate Quantity to Ship';
                    Image = CalculatePlan;
                    RunObject = report "Qty To Ship Calc Batch";
                    ToolTip = 'Calculate Quantity to Ship.';
                }
                action(MakeOrders)
                {
                    ApplicationArea = All;
                    Caption = 'Make Orders';
                    Image = MakeOrder;
                    RunObject = report "Make Orders Batch";
                    ToolTip = 'Make Orders.';
                }
                action(CalculateNextInvoicingPeriod)
                {
                    ApplicationArea = All;
                    Caption = 'Calculate Next Invoicing Period';
                    Image = CalculatePlan;
                    RunObject = report "Next Periode Calc Batch";
                    ToolTip = 'Calculate Next Invoicing Period.';
                }
            }
        }
    }
}
