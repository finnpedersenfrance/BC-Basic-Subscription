namespace FinnPedersenFrance.App.BasicSubscriptionManagement;

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
                    ToolTip = 'Calculate Quantity to Ship';
                    Image = CalculatePlan;
                    RunObject = Report "Qty to Ship Calc Batch";
                }
                action(MakeOrders)
                {
                    ApplicationArea = All;
                    Caption = 'Make Orders';
                    ToolTip = 'Make Orders';
                    Image = MakeOrder;
                    RunObject = Report "Make Orders Batch";
                }
                action(CalculateNextInvoicingPeriod)
                {
                    ApplicationArea = All;
                    Caption = 'Calculate Next Invoicing Period';
                    ToolTip = 'Calculate Next Invoicing Period';
                    Image = CalculatePlan;
                    RunObject = Report "Next Periode Calc Batch";
                }
            }
        }
    }
}

