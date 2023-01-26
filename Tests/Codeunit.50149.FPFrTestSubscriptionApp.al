codeunit 50149 "FPFr Test Subscription App"
{
    Subtype = Test;

    var
        FPFrStandardLibrary: Codeunit "FPFr Standard Library";
        Assert: Codeunit "Library Assert";
        FPFrEventSubscribers: Codeunit "FPFr Event Subscribers";



    trigger OnRun()
    begin
        // [FEATURE] Simple Subscription Management with Blanket Orders 
    end;

    [Test]
    procedure TestXMLFormatEnum()
    var
        FPFrSubscriptionEnum: Enum "FPFr Subscription Enum";

    begin
        // [SCENARIO #001] Formating Enum
        // [GIVEN] a new Enum
        // [WHEN] formating
        // [THEN] correct XML string

        Assert.AreEqual('0', FPFrStandardLibrary.XMLFormat(FPFrSubscriptionEnum::" "), '');
        Assert.AreEqual('1', FPFrStandardLibrary.XMLFormat(FPFrSubscriptionEnum::Recurring), '');
        Assert.AreEqual('2', FPFrStandardLibrary.XMLFormat(FPFrSubscriptionEnum::Stop), '');
    end;


    [Test]
    [HandlerFunctions('ConfirmHandler,MessageHandler')]

    procedure TestSubscriptionItem()
    var
        Item: Record Item;
        SalesHeader: Record "Sales Header";
        SalesLine1: Record "Sales Line";
        SalesLine2: Record "Sales Line";
        FPFrSubscriptionEnum: Enum "FPFr Subscription Enum";
        FPFrSubscriptionMgt: Codeunit "FPFr Subscription Management";
        DateExpression: DateFormula;
        ThisDay: Date;
        NextDay: Date;
        LineNumber: Integer;
        DebuggingMode: Boolean;

    begin
        // [SCENARIO #001] Subscription Item
        // [GIVEN] a new Enum
        // [WHEN] formating
        // [THEN] correct XML string

        DebuggingMode := true;
        BindSubscription(FPFrEventSubscribers);
        ThisDay := DMY2Date(10, 1, 2024);
        WorkDate(ThisDay);

        Item.FindFirst();
        Item.Validate("Subscription Type", Item."Subscription Type"::Recurring);
        Evaluate(DateExpression, '<1D>');
        Assert.AreEqual('1D', Format(DateExpression), 'Test evaluate of <1D>.');

        Item.Validate("Subscription Periodicity", DateExpression);

        if not DebuggingMode then begin
            Evaluate(DateExpression, '<-1D>');
            Assert.AreEqual('-1D', Format(DateExpression), 'Test evaluate of <-1D>.');
            // Will calculate a date in the past which is not allowed and the validate is expected to fail.
            asserterror Item.Validate("Subscription Periodicity", DateExpression);
        end;

        Item.Validate("Subscription Type", Item."Subscription Type"::" ");
        Evaluate(DateExpression, '');
        Item.Validate("Subscription Type", Item."Subscription Type"::Recurring);
        Evaluate(DateExpression, '');
        Item.Modify(true);

        SalesHeader.Validate("Document Type", SalesHeader."Document Type"::"Blanket Order");
        SalesHeader.Insert(true);
        SalesHeader.Validate("Sell-to Customer No.", '10000');
        SalesHeader.Validate("External Document No.", '123456');
        SalesHeader.Modify(true);

        SalesLine1.Init();
        SalesLine1.Validate("Document Type", SalesHeader."Document Type");
        SalesLine1.Validate("Document No.", SalesHeader."No.");
        LineNumber := FPFrSubscriptionMgt.GetNextLineNumber(SalesHeader);
        SalesLine1.Validate("Line No.", LineNumber);
        SalesLine1.Insert(true);
        SalesLine1.Validate(Type, SalesLine1.Type::Item);
        SalesLine1.Validate("No.", Item."No.");
        SalesLine1.Validate(Quantity, 1);
        SalesLine1.Validate("Qty. to Ship", 0);
        SalesLine1.Modify(true);

        SalesLine2.Init();
        SalesLine2.Validate("Document Type", SalesHeader."Document Type");
        SalesLine2.Validate("Document No.", SalesHeader."No.");
        LineNumber := FPFrSubscriptionMgt.GetNextLineNumber(SalesHeader);
        SalesLine2.Validate("Line No.", LineNumber);
        SalesLine2.Insert(true);
        SalesLine2.Validate(Type, SalesLine2.Type::Item);
        SalesLine2.Validate("No.", Item."No.");
        SalesLine2.Validate(Quantity, 1);
        SalesLine2.Validate("Qty. to Ship", 0);

        if not DebuggingMode then begin
            Evaluate(DateExpression, '<-1D>');
            // Will calculate a date in the past which is not allowed and the validate is expected to fail.
            asserterror SalesLine2.Validate("Subscription Periodicity", DateExpression);
        end;

        Evaluate(DateExpression, '<1D>');
        SalesLine2.Validate("Subscription Periodicity", DateExpression);

        SalesLine2.Validate("Subscription Type", SalesLine2."Subscription Type"::" ");
        SalesLine2.Validate("Subscription Type", SalesLine2."Subscription Type"::Stop);
        SalesLine2.Modify(true);

        FPFrSubscriptionMgt.CalculateQuantityToShipYN(SalesHeader);
        FPFrSubscriptionMgt.MakeOrderYN(SalesHeader);

        NextDay := CalcDate('1D', WorkDate());
        WorkDate := NextDay;

        FPFrSubscriptionMgt.CalculateNextSubscriptionPeriodYN(SalesHeader);
        UnbindSubscription(FPFrEventSubscribers);
    end;

    [ConfirmHandler]
    procedure ConfirmHandler(Question: Text[1024]; var Reply: Boolean);
    begin
        Reply := true;
    end;

    [MessageHandler]
    procedure MessageHandler(MessageText: Text[1024])
    begin
    end;

}