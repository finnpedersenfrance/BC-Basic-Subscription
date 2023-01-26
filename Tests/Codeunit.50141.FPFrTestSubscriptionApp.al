codeunit 50141 "FPFr Test Subscription App"
{
    Subtype = Test;
    EventSubscriberInstance = Manual;

    var
        FPFrStandardLibrary: Codeunit "FPFr Standard Library";
        Assert: Codeunit "Library Assert";
        IsInitialized: Boolean;


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
        Tomorrow: Date;
        LineNumber: Integer;

    begin
        // [SCENARIO #001] Subscription Item
        // [GIVEN] a new Enum
        // [WHEN] formating
        // [THEN] correct XML string

        WorkDate(Today);

        Item.FindFirst();
        Item.Validate("Subscription Type", Item."Subscription Type"::Recurring);
        Evaluate(DateExpression, '<1D>');
        Assert.AreEqual('1D', Format(DateExpression), 'Test evaluate of <1D>.');

        Item.Validate("Subscription Periodicity", DateExpression);
        Evaluate(DateExpression, '<-1D>');
        Assert.AreEqual('-1D', Format(DateExpression), 'Test evaluate of <-1D>.');
        // Will calculate a date in the past which is not allowed and the validate is expected to fail.
        asserterror Item.Validate("Subscription Periodicity", DateExpression);

        Item.Validate("Subscription Type", Item."Subscription Type"::" ");
        Evaluate(DateExpression, '');
        Item.Validate("Subscription Type", Item."Subscription Type"::Recurring);
        Evaluate(DateExpression, '');
        Item.Modify(true);

        SalesHeader.Validate("Document Type", SalesHeader."Document Type"::"Blanket Order");
        SalesHeader.Insert(true);
        SalesHeader.Validate("Sell-to Customer No.", '10000');
        // SalesHeader.Validate("External Document No.", '123456');
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
        // Commit(); // Testing behaviour

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

        // Evaluate(DateExpression, '<-1D>');
        // // Will calculate a date in the past which is not allowed and the validate is expected to fail.
        // asserterror SalesLine2.Validate("Subscription Periodicity", DateExpression);

        // Evaluate(DateExpression, '<1D>');
        // SalesLine2.Validate("Subscription Periodicity", DateExpression);

        SalesLine2.Validate("Subscription Type", SalesLine2."Subscription Type"::" ");
        SalesLine2.Validate("Subscription Type", SalesLine2."Subscription Type"::Stop);
        SalesLine2.Modify(true);
        // Commit(); // Testing behaviour

        FPFrSubscriptionMgt.CalculateQuantityToShipYN(SalesHeader);
        FPFrSubscriptionMgt.MakeOrderYN(SalesHeader);

        Tomorrow := CalcDate('1D', WorkDate());
        WorkDate := Tomorrow;

        FPFrSubscriptionMgt.CalculateNextSubscriptionPeriodYN(SalesHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Blnkt Sales Ord. to Ord. (Y/N)", 'OnAfterCreateSalesOrder', '', true, true)]
    local procedure SubscriptionOnAfterCreateSalesOrder(var SalesHeader: Record "Sales Header"; var SkipMessage: Boolean)
    var
        SalesPost: Codeunit "Sales-Post";
    begin
        SalesPost.Run(SalesHeader);
        SkipMessage := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Blnkt Sales Ord. to Ord. (Y/N)", 'OnBeforeShouldExit', '', true, true)]
    local procedure SubscriptionOnBeforeShouldExit(var SalesHeader: Record "Sales Header"; var Result: Boolean; var IsHandled: Boolean)
    begin
        IsHandled := true;
        Result := false;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnBeforePrePostApprovalCheckSales', '', true, true)]
    local procedure SubscriptionOnBeforePrePostApprovalCheckSales(var SalesHeader: Record "Sales Header"; var IsHandled: Boolean; var Result: Boolean)
    begin
        IsHandled := true;
        Result := true;
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
