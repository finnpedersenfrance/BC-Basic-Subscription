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

}
