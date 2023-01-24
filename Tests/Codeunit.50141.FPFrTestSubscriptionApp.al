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
        DateExpression: DateFormula;

    begin
        // [SCENARIO #001] Subscription Item
        // [GIVEN] a new Enum
        // [WHEN] formating
        // [THEN] correct XML string

        Item.FindFirst();
        Item.Validate("Subscription Type", Item."Subscription Type"::Recurring);
        if not Evaluate(DateExpression, '<1D>') then
            Error('Could not evaluate "%1".', '<1D>');
        Item.Validate("Subscription Periodicity", DateExpression);
        if not Evaluate(DateExpression, '<-1D>') then
            Error('Could not evaluate "%1".', '<-1D>');

        asserterror Item.Validate("Subscription Periodicity", DateExpression);

        Item.Validate("Subscription Type", Item."Subscription Type"::" ");
        if not Evaluate(DateExpression, '') then
            Error('Could not evaluate "%1".', '');
        Item.Validate("Subscription Type", Item."Subscription Type"::Recurring);
        if not Evaluate(DateExpression, '') then
            Error('Could not evaluate "%1".', '');
        Item.Modify(true);

        SalesHeader.Validate("Document Type", SalesHeader."Document Type"::"Blanket Order");
        SalesHeader.Insert(true);
        SalesHeader.Validate("Sell-to Customer No.", '10000');
        SalesHeader.Validate("External Document No.", '123456');
        SalesHeader.Modify(true);

        SalesLine.Init();
        SalesLine.Validate("Document Type", SalesHeader."Document Type");
        SalesLine.Validate("Document No.", SalesHeader."No.");
        SalesLine.Validate("Line No.", 10000);
        SalesLine.Insert(true);
        SalesLine.Validate(Type, SalesLine.Type::Item);
        SalesLine.Validate("No.", Item."No.");
        SalesLine.Validate(Quantity, 1);
        SalesLine.Modify(true);
    end;
}
