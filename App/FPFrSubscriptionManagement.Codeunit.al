namespace FinnPedersenFrance.App.BasicSubscriptionManagement;

using Microsoft.Sales.Document;
using Microsoft.Inventory.Item;

codeunit 50140 "FPFr Subscription Management"
{
    trigger OnRun()
    begin

    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterCopyFromItem', '', true, true)]
    local procedure SubscriptionOnAfterCopyFromItem(var SalesLine: Record "Sales Line"; Item: Record Item)
    begin
        SalesLine."Subscription Type" := Item."Subscription Type";
        SalesLine."Subscription Periodicity" := Item."Subscription Periodicity";
    end;


    procedure MakeOrderYN(SalesHeader: Record "Sales Header")
    var
        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
    begin
        if ApprovalsMgmt.PrePostApprovalCheckSales(SalesHeader) then
            Codeunit.Run(Codeunit::"Blnkt Sales Ord. to Ord. (Y/N)", SalesHeader);
    end;

    procedure CalculateQuantityToShipYN(SalesHeader: Record "Sales Header")
    var
        ConfirmMsg: TextConst ENU = 'Do you want to calculate the Quantity to Ship?';
        CalculatedMsg: TextConst ENU = 'Quantity to Ship was calculated.';

    begin
        SalesHeader.TestField("Document Type", SalesHeader."Document Type"::"Blanket Order");
        if Confirm(ConfirmMsg, false) then begin
            CalculateQuantityToShipOne(SalesHeader);
            Message(CalculatedMsg);
        end;
    end;

    procedure CalculateQuantityToShipOne(SalesHeader: Record "Sales Header")
    var
        BlanketOrderSalesLine: Record "Sales Line";
    begin
        SalesHeader.TestField("Document Type", SalesHeader."Document Type"::"Blanket Order");

        BlanketOrderSalesLine.Reset();
        BlanketOrderSalesLine.SetRange("Document Type", SalesHeader."Document Type");
        BlanketOrderSalesLine.SetRange("Document No.", SalesHeader."No.");
        BlanketOrderSalesLine.SetRange("Qty. to Ship", 0);
        BlanketOrderSalesLine.SetFilter("Shipment Date", '..%1', WorkDate());
        if BlanketOrderSalesLine.FindSet() then
            repeat
                BlanketOrderSalesLine.Validate("Qty. to Ship", BlanketOrderSalesLine.Quantity - BlanketOrderSalesLine."Quantity Invoiced");
                BlanketOrderSalesLine.Modify(true);
            until BlanketOrderSalesLine.Next() = 0;
    end;

    procedure CalculateNextSubscriptionPeriodYN(SalesHeader: Record "Sales Header")
    var
        ConfirmMsg: TextConst ENU = 'Do you want to calculate the next Subscription periodes?';
        CalculatedMsg: TextConst ENU = 'Next Subscription periods have been calculated.';
    begin
        SalesHeader.TestField("Document Type", SalesHeader."Document Type"::"Blanket Order");
        if Confirm(ConfirmMsg, false) then begin
            CalculateNextSubscriptionPeriodOne(SalesHeader);
            Message(CalculatedMsg);
        end;
    end;

    procedure CalculateNextSubscriptionPeriodOne(SalesHeader: Record "Sales Header")
    var
        BlanketOrderSalesLine: Record "Sales Line";
        NewBlanketOrderSalesLine: Record "Sales Line";
        ExistsBlanketOrderSalesLine: Record "Sales Line";

    begin
        SalesHeader.TestField("Document Type", SalesHeader."Document Type"::"Blanket Order");

        BlanketOrderSalesLine.Reset();
        BlanketOrderSalesLine.SetRange("Document Type", SalesHeader."Document Type");
        BlanketOrderSalesLine.SetRange("Document No.", SalesHeader."No.");
        BlanketOrderSalesLine.SetRange("Subscription Type", BlanketOrderSalesLine."Subscription Type"::Recurring);

        if BlanketOrderSalesLine.FindSet() then
            repeat
                if (BlanketOrderSalesLine.Quantity = BlanketOrderSalesLine."Quantity Invoiced") then begin
                    ExistsBlanketOrderSalesLine.Reset();
                    ExistsBlanketOrderSalesLine.SetRange("Document Type", SalesHeader."Document Type");
                    ExistsBlanketOrderSalesLine.SetRange("Document No.", SalesHeader."No.");
                    ExistsBlanketOrderSalesLine.SetRange(Type, BlanketOrderSalesLine.Type);
                    ExistsBlanketOrderSalesLine.SetRange("No.", BlanketOrderSalesLine."No.");
                    ExistsBlanketOrderSalesLine.SetRange("Shipment Date", CalcDate(BlanketOrderSalesLine."Subscription Periodicity", BlanketOrderSalesLine."Shipment Date"));
                    if ExistsBlanketOrderSalesLine.IsEmpty() then begin
                        // Create a copy of the line and update field by field with Validate
                        NewBlanketOrderSalesLine.Init();
                        NewBlanketOrderSalesLine."Document Type" := BlanketOrderSalesLine."Document Type";
                        NewBlanketOrderSalesLine."Document No." := BlanketOrderSalesLine."Document No.";
                        NewBlanketOrderSalesLine."Line No." := GetNextLineNumber(SalesHeader);
                        NewBlanketOrderSalesLine.Insert(true);
                        NewBlanketOrderSalesLine.Validate(Type, BlanketOrderSalesLine.Type);
                        NewBlanketOrderSalesLine.Validate("No.", BlanketOrderSalesLine."No.");
                        NewBlanketOrderSalesLine.Validate(Description, BlanketOrderSalesLine.Description);
                        NewBlanketOrderSalesLine.Validate("Unit Price", BlanketOrderSalesLine."Unit Price");
                        NewBlanketOrderSalesLine.Validate(Quantity, BlanketOrderSalesLine.Quantity);
                        NewBlanketOrderSalesLine.Validate("Qty. to Ship", 0);
                        NewBlanketOrderSalesLine.Validate("Shipment Date", CalcDate(BlanketOrderSalesLine."Subscription Periodicity", BlanketOrderSalesLine."Shipment Date"));
                        NewBlanketOrderSalesLine.Validate("Subscription Type", BlanketOrderSalesLine."Subscription Type");
                        NewBlanketOrderSalesLine.Validate("Subscription Periodicity", BlanketOrderSalesLine."Subscription Periodicity");
                        NewBlanketOrderSalesLine.Modify(true);
                    end;
                end;
            until BlanketOrderSalesLine.Next() = 0;
    end;

    procedure GetNextLineNumber(SalesHeader: Record "Sales Header"): Integer;
    var
        SalesLine: Record "Sales Line";
        NextLineNumber: Integer;
    begin
        SalesLine.Reset();
        SalesLine.SetRange("Document Type", SalesHeader."Document Type");
        SalesLine.SetRange("Document No.", SalesHeader."No.");
        if SalesLine.FindLast() then
            NextLineNumber := SalesLine."Line No." + 10000
        else
            NextLineNumber := 10000;
        exit(NextLineNumber);
    end;
}