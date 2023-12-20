namespace FinnPedersenFrance.App.BasicSubscriptionManagement;

using Microsoft.Sales.Document;

report 50142 "FPFr Make Orders Batch"
{
    Caption = 'Make Orders from Blanket Order Lines ready to ship';
    ProcessingOnly = true;
    UsageCategory = None;

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            DataItemTableView = sorting("Document Type", "No.") where("Document Type" = const("Blanket Order"));
            RequestFilterFields = "No.", Status;
            RequestFilterHeading = 'Blanket Sales Order';

            trigger OnAfterGetRecord()
            begin
                Counter := Counter + 1;
                WindowDialog.Update(1, "No.");
                WindowDialog.Update(2, ROUND(Counter / CounterTotal * 10000, 1));
                Clear(BlanketSalesOrdertoOrder);
                if BlanketSalesOrdertoOrder.Run("Sales Header") then begin
                    CounterOK := CounterOK + 1;
                    if MarkedOnly then
                        Mark(false);
                end;
            end;

            trigger OnPostDataItem()
            begin
                WindowDialog.Close();
                Message(CounterLbl, CounterOK, CounterTotal);
            end;

            trigger OnPreDataItem()
            begin
                CounterTotal := Count;
                WindowDialog.Open(UpdatingBlanketOrdersLbl);
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        BlanketSalesOrdertoOrder: Codeunit "Blanket Sales Order to Order";
        UpdatingBlanketOrdersLbl: label 'Updating Blanket Orders  #1########## @2@@@@@@@@@@@@@', Comment = '%1 = Order Number; %2 = Counter';
        CounterLbl: label '%1 blanket orders out of a total of %2 have now been evaluated.', Comment = '%1 = Counter; %2 = Counter Total';
        WindowDialog: Dialog;
        CounterTotal: Integer;
        Counter: Integer;
        CounterOK: Integer;

    procedure InitializeRequest()
    begin
    end;
}
