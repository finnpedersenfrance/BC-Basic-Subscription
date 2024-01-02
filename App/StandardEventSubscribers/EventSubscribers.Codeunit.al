namespace FinnPedersenFrance.App.BasicSubscriptionManagement;

using Microsoft.Sales.Document;
using Microsoft.Sales.Posting;

codeunit 50141 "Event Subscribers"
{
    EventSubscriberInstance = Manual;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Blnkt Sales Ord. to Ord. (Y/N)", 'OnAfterCreateSalesOrder', '', true, true)]
    local procedure SubscriptionOnAfterCreateSalesOrder(var SalesHeader: Record "Sales Header"; var SkipMessage: Boolean)
    var
        SalesPost: Codeunit "Sales-Post";
    begin
        if not (SalesHeader.Ship and SalesHeader.Invoice) then begin
            SalesHeader.Ship := true;
            SalesHeader.Invoice := true;
            SalesHeader.Modify(true);
        end;

        SalesPost.Run(SalesHeader);
        SkipMessage := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Blnkt Sales Ord. to Ord. (Y/N)", 'OnBeforeShouldExit', '', true, true)]
    local procedure SubscriptionOnBeforeShouldExit(var SalesHeader: Record "Sales Header"; var Result: Boolean; var IsHandled: Boolean)
    begin
        IsHandled := true;
        Result := false;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::System.Automation."Approvals Mgmt.", 'OnBeforePrePostApprovalCheckSales', '', true, true)]
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

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforeCheckHeaderPostingType', '', true, true)]
    // local procedure SubscriptionOnBeforeCheckHeaderPostingType(var SalesHeader: Record "Sales Header"; var IsHandled: Boolean)
    // begin
    //     IsHandled := true;
    // end;

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforePostSalesDoc', '', true, true)]
    // local procedure SubscriptionOnBeforePostSalesDoc(var SalesHeader: Record "Sales Header"; CommitIsSuppressed: Boolean; PreviewMode: Boolean; var HideProgressWindow: Boolean; var IsHandled: Boolean)
    // begin
    //     HideProgressWindow := true;
    //     IsHandled := true;
    // end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Blanket Sales Order to Order", 'OnBeforeCheckBlanketOrderLineQuantity', '', true, true)]
    local procedure SubscriptionOnBeforeCheckBlanketOrderLineQuantity(var BlanketOrderSalesLine: Record "Sales Line"; QuantityOnOrders: Decimal; var IsHandled: Boolean)
    begin
        IsHandled := true;
    end;
}
