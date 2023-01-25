codeunit 50141 "FPFr Test Subscription App"
{
    Subtype = Test;

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
    procedure TestSubscriptionItem()
    var
        Item: Record Item;
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        FPFrSubscriptionEnum: Enum "FPFr Subscription Enum";
        FPFrSubscriptionMgt: Codeunit "FPFr Subscription Management";
        DateExpression: DateFormula;
        LineNumber: Integer;

    begin
        // [SCENARIO #001] Subscription Item
        // [GIVEN] a new Enum
        // [WHEN] formating
        // [THEN] correct XML string

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
        SalesHeader.Validate("External Document No.", '123456');
        SalesHeader.Modify(true);

        SalesLine.Init();
        SalesLine.Validate("Document Type", SalesHeader."Document Type");
        SalesLine.Validate("Document No.", SalesHeader."No.");
        LineNumber := FPFrSubscriptionMgt.GetNextLineNumber(SalesHeader);
        SalesLine.Validate("Line No.", LineNumber);
        SalesLine.Insert(true);
        SalesLine.Validate(Type, SalesLine.Type::Item);
        SalesLine.Validate("No.", Item."No.");
        SalesLine.Validate(Quantity, 1);
        SalesLine.Modify(true);

        SalesLine.Init();
        SalesLine.Validate("Document Type", SalesHeader."Document Type");
        SalesLine.Validate("Document No.", SalesHeader."No.");
        LineNumber := FPFrSubscriptionMgt.GetNextLineNumber(SalesHeader);
        SalesLine.Validate("Line No.", LineNumber);
        SalesLine.Insert(true);
        SalesLine.Validate(Type, SalesLine.Type::Item);
        SalesLine.Validate("No.", Item."No.");
        SalesLine.Validate(Quantity, 1);

        Evaluate(DateExpression, '<-1D>');
        // Will calculate a date in the past which is not allowed and the validate is expected to fail.
        asserterror SalesLine.Validate("Subscription Periodicity", DateExpression);

        Evaluate(DateExpression, '<1D>');
        SalesLine.Validate("Subscription Periodicity", DateExpression);

        SalesLine.Validate("Subscription Type", SalesLine."Subscription Type"::" ");
        SalesLine.Validate("Subscription Type", SalesLine."Subscription Type"::Stop);
        SalesLine.Modify(true);

        FPFrSubscriptionMgt.CalculateQuantityToShipYN(SalesHeader);
        FPFrSubscriptionMgt.MakeOrderYN(SalesHeader);
        FPFrSubscriptionMgt.CalculateNextSubscriptionPeriodYN(SalesHeader);
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
