codeunit 50141 "FPFr Event Subscribers"
{
    EventSubscriberInstance = Manual;

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

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnBeforeCheckWarehouseForQtyToShip', '', true, true)]
    local procedure SubscriptionOnBeforeCheckWarehouseForQtyToShip(SalesLine: Record "Sales Line"; CurrentFieldNo: Integer; var IsHandled: Boolean; xSalesLine: Record "Sales Line")
    begin
        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforeCheckPostingFlags', '', true, true)]
    local procedure SubscriptionOnBeforeCheckPostingFlags(var SalesHeader: Record "Sales Header"; var IsHandled: Boolean)
    begin
        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforeCheckHeaderPostingType', '', true, true)]
    local procedure SubscriptionOnBeforeCheckHeaderPostingType(var SalesHeader: Record "Sales Header"; var IsHandled: Boolean)
    begin
        IsHandled := true;
    end;

}
