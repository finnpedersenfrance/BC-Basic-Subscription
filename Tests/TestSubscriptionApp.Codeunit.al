namespace FinnPedersenFrance.BasicSubscriptionManagement;

using Microsoft.Inventory.Item;
using Microsoft.Sales.Document;
using FinnPedersenFrance.Tools.Library;

codeunit 50144 "Test Subscription App"
{
    Subtype = Test;

    var
        Assert: Codeunit Assert;
        EventSubscribers: Codeunit "Event Subscribers";
        StandardLibrary: Codeunit "Standard Library";

    trigger OnRun()
    begin
        // [FEATURE] Simple Subscription Management with Blanket Orders
    end;

    [Test]
    procedure TestXMLFormatEnum()
    var
        SubscriptionEnum: Enum "Subscription Enum";

    begin
        // [SCENARIO #001] Formating Enum
        // [GIVEN] a new Enum
        // [WHEN] formating
        // [THEN] correct XML string

        Assert.AreEqual('0', StandardLibrary.XMLFormat(SubscriptionEnum::" "), '');
        Assert.AreEqual('1', StandardLibrary.XMLFormat(SubscriptionEnum::Recurring), '');
        Assert.AreEqual('2', StandardLibrary.XMLFormat(SubscriptionEnum::Stop), '');
    end;

    [Test]
    [HandlerFunctions('ConfirmHandler,MessageHandler')]

    procedure TestSubscriptionItem()
    var
        Item1: Record Item;
        Item2: Record Item;
        SalesHeader: Record "Sales Header";
        SalesLine1: Record "Sales Line";
        SalesLine2: Record "Sales Line";
        SubscriptionManagement: Codeunit "Subscription Management";
        DateExpression: DateFormula;
        DebuggingMode: Boolean;
        ThisDay: Date;
        Counter: Integer;
        LineNumber: Integer;
        BlanketOrderStatus: Text;

    begin
        // [SCENARIO #001] Subscription Item
        // [GIVEN] a new Enum
        // [WHEN] formating
        // [THEN] correct XML string

        DebuggingMode := true;
        BindSubscription(EventSubscribers);
        ThisDay := DMY2Date(1, 1, 2024);
        WorkDate(ThisDay);

        Item1.Get('1960-S');
        Item1.Validate("Subscription Type", Item1."Subscription Type"::Recurring);
        Evaluate(DateExpression, '<1D>');
        Assert.AreEqual('1D', Format(DateExpression), 'Test evaluate of <1D>.');
        Item1.Validate("Subscription Periodicity", DateExpression);

        if not DebuggingMode then begin
            Evaluate(DateExpression, '<-1D>');
            Assert.AreEqual('-1D', Format(DateExpression), 'Test evaluate of <-1D>.');
            // Will calculate a date in the past which is not allowed and the validate is expected to fail.
            asserterror Item1.Validate("Subscription Periodicity", DateExpression);
        end;

        Item1.Validate("Subscription Type", Item1."Subscription Type"::" ");
        Item1.Validate("Subscription Type", Item1."Subscription Type"::Recurring);
        Evaluate(DateExpression, '<1D>');
        Item1.Validate("Subscription Periodicity", DateExpression);
        Item1.Modify(true);

        Item2.Get('1900-S');
        Item2.Validate("Subscription Type", Item2."Subscription Type"::Recurring);
        Evaluate(DateExpression, '<1D>');
        Assert.AreEqual('1D', Format(DateExpression), 'Test evaluate of <1D>.');
        Item2.Validate("Subscription Periodicity", DateExpression);
        Item2.Modify(true);

        SalesHeader.Validate("Document Type", SalesHeader."Document Type"::"Blanket Order");
        SalesHeader.Insert(true);
        SalesHeader.Validate("Sell-to Customer No.", '10000');
        SalesHeader.Validate("External Document No.", '123456');
        SalesHeader.Modify(true);
        BlanketOrderStatus := SalesHeaderStatus(SalesHeader);

        SalesLine1.Init();
        SalesLine1.Validate("Document Type", SalesHeader."Document Type");
        SalesLine1.Validate("Document No.", SalesHeader."No.");
        LineNumber := SubscriptionManagement.GetNextLineNumber(SalesHeader);
        SalesLine1.Validate("Line No.", LineNumber);
        SalesLine1.Insert(true);
        SalesLine1.Validate(Type, SalesLine1.Type::Item);
        SalesLine1.Validate("No.", Item1."No.");
        SalesLine1.Validate(Quantity, 1);
        SalesLine1.Validate("Qty. to Ship", 0);
        SalesLine1.Validate("Shipment Date", ThisDay);
        SalesLine1.Validate("Subscription Type", SalesLine1."Subscription Type"::Recurring);
        Evaluate(DateExpression, '<1D>');
        SalesLine1.Validate("Subscription Periodicity", DateExpression);

        SalesLine1.Modify(true);
        BlanketOrderStatus := SalesHeaderStatus(SalesHeader);

        SalesLine2.Init();
        SalesLine2.Validate("Document Type", SalesHeader."Document Type");
        SalesLine2.Validate("Document No.", SalesHeader."No.");
        LineNumber := SubscriptionManagement.GetNextLineNumber(SalesHeader);
        SalesLine2.Validate("Line No.", LineNumber);
        SalesLine2.Insert(true);
        SalesLine2.Validate(Type, SalesLine2.Type::Item);
        SalesLine2.Validate("No.", Item2."No.");
        SalesLine2.Validate(Quantity, 1);
        SalesLine2.Validate("Qty. to Ship", 0);
        SalesLine2.Validate("Shipment Date", ThisDay);

        if not DebuggingMode then begin
            Evaluate(DateExpression, '<-1D>');
            // Will calculate a date in the past which is not allowed and the validate is expected to fail.
            asserterror SalesLine2.Validate("Subscription Periodicity", DateExpression);
        end;

        Evaluate(DateExpression, '<1D>');
        SalesLine2.Validate("Subscription Periodicity", DateExpression);

        SalesLine2.Validate("Subscription Type", SalesLine2."Subscription Type"::" ");
        SalesLine2.Validate("Subscription Type", SalesLine2."Subscription Type"::Stop);
        SalesLine2.Validate("Subscription Type", SalesLine2."Subscription Type"::Recurring);
        Evaluate(DateExpression, '<1D>');
        SalesLine2.Validate("Subscription Periodicity", DateExpression);

        SalesLine2.Modify(true);
        BlanketOrderStatus := SalesHeaderStatus(SalesHeader);

        for Counter := 1 to 10 do begin
            SubscriptionManagement.CalculateQuantityToShipYN(SalesHeader);
            BlanketOrderStatus := SalesHeaderStatus(SalesHeader);

            SubscriptionManagement.MakeOrderYN(SalesHeader);
            SimulatePosting(SalesHeader);
            BlanketOrderStatus := SalesHeaderStatus(SalesHeader);

            SubscriptionManagement.CalculateNextSubscriptionPeriodYN(SalesHeader);
            BlanketOrderStatus := SalesHeaderStatus(SalesHeader);

            ThisDay := CalcDate('<1D>', ThisDay);
            WorkDate(ThisDay);
        end;

        UnbindSubscription(EventSubscribers);
    end;

    procedure SimulatePosting(SalesHeader: Record "Sales Header")
    var
        SalesLine: Record "Sales Line";
    begin
        SalesLine.SetRange("Document Type", SalesHeader."Document Type");
        SalesLine.SetRange("Document No.", SalesHeader."No.");
        if SalesLine.FindSet() then
            repeat
                SalesLine."Qty. to Invoice" := 0;
                SalesLine."Qty. to Ship" := 0;
                SalesLine."Quantity Shipped" := SalesLine.Quantity;
                SalesLine."Quantity Invoiced" := SalesLine.Quantity;
                SalesLine.Modify(false);
            until SalesLine.Next() = 0;
    end;

    procedure SalesHeaderStatus(SalesHeader: Record "Sales Header"): Text
    var
        SalesLine: Record "Sales Line";
        StatusTxt: Label 'Line %1, Date %2, Qty %3, To Ship %4, To inv %5, Shipped %6, Invoiced %7',
               Comment = '%1 = Line No., %2 = Date, %3 = Quantity, %4 = Qty. to Ship, %5 = Qty. to Invoice, %6 = Quantity Shipped, %7 = Quantity Invoiced)';
        String: Text;
    begin
        // String := StrSubstNo('%1 %2 %3\', Format(SalesHeader."Document Type"), SalesHeader."No.", SalesHeader."Document Date");
        SalesLine.SetRange("Document Type", SalesHeader."Document Type");
        SalesLine.SetRange("Document No.", SalesHeader."No.");
        if SalesLine.FindSet() then
            repeat
                String := String +
                    StrSubstNo(StatusTxt,
                        SalesLine."Line No.",
                        Format(SalesLine."Shipment Date", 0, 9),
                        SalesLine.Quantity,
                        SalesLine."Qty. to Ship",
                        SalesLine."Qty. to Invoice",
                        SalesLine."Quantity Shipped",
                        SalesLine."Quantity Invoiced") +
                    '\';
            until SalesLine.Next() = 0;
        exit(String);
    end;

#pragma warning disable CM0030 // Remove unused variables
    [ConfirmHandler]
    procedure ConfirmHandler(Question: Text[1024]; var Reply: Boolean)
    begin
        Reply := true;
    end;

    [MessageHandler]
    procedure MessageHandler(MessageText: Text[1024])
    begin
    end;
#pragma warning restore CM0030 // Remove unused variables
}
