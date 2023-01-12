Report 50140 "FPFr Next Periode Calc Batch"
{
    Caption = 'Calculate Next Subscription Period';
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
                Clear(FPFrSubscriptionManagement);
                FPFrSubscriptionManagement.CalculateNextSubscriptionPeriodOne("Sales Header");
                CounterOK := CounterOK + 1;
                if MarkedOnly then
                    Mark(false);
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
        FPFrSubscriptionManagement: Codeunit "FPFr Subscription Management";
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

